# create instance on Alibaba cloud


## Prerequisites

- If a VPC does not exist on the desired region, create new one :
```
aliyun vpc CreateVpc \
--RegionId ap-southeast-3 \
--CidrBlock 192.168.0.0/16
```

- After VPC creation, add a vSwitch :
```
aliyun vpc CreateVSwitch \
--CidrBlock 192.168.0.0/16 \
--VpcId vpc-8ps442dswpezokv5iqhhz \
--ZoneId=ap-southeast-3b \
--RegionId ap-southeast-3 
```

After vSwtich creation, create a new SecurityGroup (if not already exist) : 
```
aliyun ecs CreateSecurityGroup \
--RegionId ap-southeast-3 \
--VpcId vpc-8ps442dswpezokv5iqhhz
```

## new ECS Instance creation :

- Create a new ECS instance by launching : 
```
aliyun ecs RunInstances \
--RegionId ap-southeast-3 \
--ImageId debian_12_2_x64_20G_alibase_20231012.vhd \
--InstanceType ecs.g6.xlarge \
--InstanceName xunlei-ftp-3 \
--SecurityGroupId sg-8ps2cxcowynzxdx2xpwy \
--VSwitchId vsw-8psata8mse1kkea5lsy3a \
--PeriodUnit Month \
--Period 3 \
--InternetMaxBandwidthOut 1 \
--Password <password>
```

- See [RunInstances doc](https://www.alibabacloud.com/help/en/ecs/developer-reference/api-runinstances#doc-api-Ecs-RunInstances) for more details 



### Fastest method (prerequisite must be met)


- Find below an example of command to create an ECS instance : 
```
aliyun ecs CreateInstance --RegionId ap-southeast-5 --ImageId debian_12_2_x64_20G_alibase_20231012.vhd --InstanceType ecs.g6.large --InstanceName xunlei-ftp-2 --Password <password>
```

- to have regionID exact value : look at [RegionID documentation](https://www.alibabacloud.com/help/en/dms/developer-reference/regionid-parameter)

- To find available instance type per region : 
```
aliyun ecs DescribeAvailableResource --DestinationResource InstanceType --RegionId ap-southeast-1 --InstanceType ecs.g6.large
```
or 
```
aliyun ecs DescribeInstanceTypes  --InstanceTypeFamily ecs.g6.large --output cols=InstanceTypeId,RegionId rows=InstanceTypes.InstanceType[]
```

- To find available image type per region : 
```
aliyun ecs DescribeImages --RegionId ap-southeast-3 --output cols=ImageName,Status,OSNameEn,OSType,Progress,Usage rows=Images.Image[]
```

## Sources : 

- [RegionID doc](https://www.alibabacloud.com/help/en/dms/developer-reference/regionid-parameter)
- [vSwitch doc](https://www.alibabacloud.com/help/en/vpc/developer-reference/api-vpc-2016-04-28-createvswitch#api-detail-0)
- [RunInstance doc](https://www.alibabacloud.com/help/en/ecs/developer-reference/api-runinstances#parameters)
- [DescribeAvailableResource doc](https://www.alibabacloud.com/help/en/ecs/developer-reference/api-describeavailableresource)
- [CreateInstance doc](https://www.alibabacloud.com/help/en/ecs/developer-reference/api-createinstance?spm=a2c63.p38356.0.0.7f135725tbWAfh#section-2rj-tcg-9y5)
- [Create and manage an ECS instance tutorial cli](https://www.alibabacloud.com/help/en/ecs/getting-started/create-and-manage-an-ecs-instance-by-using-cli-commands)

- [ documentation for cli usage on alibaba ](https://static-aliyun-doc.oss-cn-hangzhou.aliyuncs.com/download%2Fpdf%2F151772%2FCLI_Sample_intl_en-US.pdf)