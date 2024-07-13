# 기획 단계

### 필수 작업 사항
- [X] `kubernetes` 기반 인프라 환경 구현
- [X] `Terraform` 적용

### 추가 작업 사항
- [X] api 서버 내부 통신 환경 구현
- [X] `AWS` 를 활용한 `CSP` 인프라 구현
- [X] Helm chart 기반 배포
- [ ] 모니터링/로깅 환경 설계 (ELK, Prometheus&Grafana)

</br>
</br>


# 인프라 환경
내부 통신만 진행하는 `Auth-api` 와, 실제 외부에 통신을 진행하는 `Users-api` 를 고려했을 때, 다음의 기술들이 필요하다고 판단했습니다.

## EKS
과제 수행에 반드시 필요한 기술 입니다.

## Terraform
과제 수행에 반드시 필요한 기술 입니다.

## AWS VPC
각 서버와 `DB` 의 업무에 따라 작업 영역을 적절히 배치할 필요가 있다고 생각했습니다. `Users-api` 를 위한 `public subnet` 과, `DB, Auth-api` 를 위한 `private subnet1`, `private subnet2` 로 크게 3가지로 영역을 나눴습니다.

## ELB
`Users-api` ,`Auth-api` 통신을 위한 `Kubernetes Service` 를 적용합니다. 특히 `Users-api` 는 외부 통신 및 스케일링을 통한 부하분산을 작업해줄 `LoadBalancer` 가 필요하여 `ELB` 를 채택했습니다.

`Auth-api` 의 `Kubernetes Service` 는 클러스터 내의 통신만 가능하면 되므로 `ClusterIP` 타입을 적용해습니다.

## IAM
`EKS` 를 사용하기 위해서는 반드시 적용되어야 하는 요소로, 클러스터의 제어권을 위한 권한과 `NodeGroup`의 워커 노드의 제어를 위한 권한이 필요하여 적용했습니다.

> `EKS` - `AmazonEKSClusterPolicy` , `AmazonEKSVPCResourceController`
> 
> `NodeGroup` - `AmazonEC2ContainerRegistryReadOnly`, `AmazonEKS_CNI_Policy` , `AmazonEKSWorkerNodePolicy`

## EC2
향후 `NodeGroup` 에서 생성하는 워커 노드를 `EC2` 인스턴스로 적용했습니다.

## Helm
`back-end` 환경에 대한 배포를 위해 적용했습니다. `Terrform` 이 `Helm Chart` 정보를 읽어드려, 배포에 적용하는 방식으로 구현했습니다.

</br>
</br>


# 인프라 구성도
본래 `DynamoDB` 를 활용한 `private subnet 2` 공간에 넣으려 했으나, 시간관계상 그 부분은 구현하지 못했습니다.

현재는 `MongoDB` 자체 클러스터를 인프라 외부에 있습니다.

![인프라 환경](./images/인프라%20환경.png)


# 소모 시간도
![environment](./images/environment.png)
## environment
13~14분 정도 (eks: 8분, nodegroup: 2분, vpc: 2분)

## distribution(helm)
20초 이하 (back-end 만 가정)




# 프로젝트 구조

## `_variables_`
공통 변수 사항을 저장하는 공간입니다. 재사용성이 높은 변수들을 해당 폴더에 저장하고, 이를 불러오는 방식을 통해 가독성을 높였습니다. 

## modules
구성할 인프라 서비스를 정의하는 공간입니다. 해당 폴더에서는 `vpc` , `eks` , `service` 기능을 정의했습니다.

## environent
실제 정의한 인프라 정보를 기반으로 `CSP` 에 적용시키는 공간입니다.

## deployment
`Helm Chart` 정보를 기반으로 백엔드 어플리케이션 배포가 이루어지는 공간입니다.


```
📦 
├─ .gitignore
├─ _variables_
│  └─ dev
│     ├─ charts_info.yaml
│     ├─ common_info.yaml
│     ├─ common_tags.yaml
│     ├─ eks_cluster_info.yaml
│     ├─ service_info.yaml
│     └─ vpc_info.yaml
├─ deployment
│  └─ dev
│     ├─ charts
│     │  └─ api
│     │     ├─ Chart.yaml
│     │     ├─ templates
│     │     │  ├─ auth-api-deployment.yaml
│     │     │  └─ users-api-deployment.yaml
│     │     └─ values.yaml
│     └─ terraform
│        ├─ main.tf
│        └─ variables.tf
├─ environment
│  └─ dev
│     ├─ locals.tf
│     ├─ main.tf
│     ├─ provider.tf
│     └─ variables.tf
└─ modules
   ├─ eks
   │  ├─ cluster-role.tf
   │  ├─ cluster-sg.tf
   │  ├─ cluster.tf
   │  ├─ nodegroup-role.tf
   │  ├─ nodegroup-sg.tf
   │  ├─ nodegroup.tf
   │  ├─ outputs.tf
   │  └─ variables.tf
   ├─ service
   │  ├─ main.tf
   │  └─ variables.tf
   └─ vpc
      ├─ igw.tf
      ├─ nat.tf
      ├─ outputs.tf
      ├─ route.tf
      ├─ subnet.tf
      ├─ variables.tf
      └─ vpc.tf
```