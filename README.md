Course: Infrastructure as Code (PROG8830)  
College: Conestoga College  
Group Members: `Preethi, Suman, Sumanth`  
Instructor:Mike  
Semester: Winter 2025  

`Objective`

The goal of this lab is to demonstrate the practical application of advanced Terraform features—such as loops, functions, expressions, and modular infrastructure management—within the context of a web application. The infrastructure includes compute instances, a load balancer, a database, and supporting components.

`How to Run the Project`

terraform init
terraform plan
terraform apply
terraform destroy


 `Task Overview and Functionality`

Task 1: Leveraging Terraform Loops

Objective: 
Showcase how to use Terraform's looping constructs (`count` and `for_each`) for efficient resource provisioning.

Implementation: 
- `count`: Utilized to launch multiple identical EC2 instances. This is ideal when the number of instances is fixed and uniform.
- `for_each`: Used to provision resources like AWS security groups with unique names and port configurations, iterating over a map for dynamic resource creation.

Outcome:  
Provisioned multiple compute instances and dynamically configured security groups, highlighting the practical differences between `count` and `for_each`.


Task 2: Utilizing Built-in Terraform Functions

Objective:  
Explore and apply various built-in Terraform functions to streamline configuration and automate resource provisioning.

Implementation Examples: 
- String Functions: Convert names to uppercase using `upper(var.name)` for standardized tagging.

- Numeric Functions: Ensure minimum thresholds with `max(var.instance_count, 2)`.

- Collection Functions: Combine values using `concat(var.security_groups, ["default"])`.

- Date/Time Functions: Tag resources with the current deployment time using `timestamp()`.

- Networking Functions: Generate subnet ranges using `cidrsubnet()` for efficient IP address management.

Outcome: 
These functions enabled dynamic behavior, data manipulation, and more intelligent, self-adapting infrastructure code.

Task 3: Enhancing Terraform with Modularity and Expressions

Objective: 
Improve Terraform configuration maintainability and scalability through modular design and advanced expressions.

`Implementation:` 
- Created reusable `modules` for compute and security resources to avoid duplication.

- Applied `conditional logic and expressions` to adapt infrastructure based on input variables.
- Leveraged `variable interpolation` and `data sources` for dynamic configuration and clean code.

`Outcome`: 
Achieved cleaner, reusable, and easily extensible Terraform configurations that align with best practices in Infrastructure as Code.

`Conclusion`

This lab effectively demonstrated the use of advanced Terraform features to build scalable, flexible, and maintainable infrastructure.  

- Task 1 (Loops): Provided insights into when to use `count` for identical resources and `for_each` for uniquely configured ones.

- Task 2 (Functions): Showed how built-in functions simplify configuration logic and automate infrastructure behavior.

- Task 3 (Modularity & Expressions): Highlighted the importance of modular design and dynamic expressions for efficient, production-ready IaC practices.

