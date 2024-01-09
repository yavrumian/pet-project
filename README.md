<h1 align="center">
Pet Project
</h1>
<h2 align="center">
with Terraform, Helm, EKS and GitHub Actions on AWS
</h2>

![alt text](https://naviteq-banner.s3.eu-west-1.amazonaws.com/banner%201.png)

---

### About
1) Is a python application (webserver). It serves HTTP requests at the next routes:
```bash
8080:/
8080/ping 
8080:/health
```

```bash
/ping   - return PONG in HTML format, status code 200 OK  
/       - return current weather in London, UK in HTML format, status code 200 OK 
/health - return HEALTHY, in JSON format, status code 200 OK
```

For weather data this API is used: https://openweathermap.org/current  

2) App is Dockerized

3) Terraform creates:
- VPC
- Subnets
- SGs
- Routing tables
- NAT GW
- EKS cluster 
- ECR


4) Deployed via Helm3 application to EKS
