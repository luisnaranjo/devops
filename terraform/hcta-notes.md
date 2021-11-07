# HASHICORP CERTIFIED TERRAFORM ASSOCIATE - NOTES
## HASHICORP CERTIFIED TERRAFORM ASSOCIATE - INTRODUCTION
### INFRASTRUCTURE AS CODE
Infrastructure as Code (or IaC) is a method of writing down human-readable code to deploy resources in the cloud and elsewhere (VMs, disks, apps, etc).

IaC enables DevOps. Codification of deployment means it can be tracked in version control, enabling better visibility and collaboration across teams.

For the majority of IaC tools, the code is usually declarative, this means you declare or write down exactly what you want without caring about underlying functions or API calls will need to be made to deploy the infrastructure.
However, it can be the case that the code is procedural (imperative).



### CLOUD-AGNOSTIC IAC WITH TERRAFORM
The language used in Terraform is Hashicorp Configuration Language (HCL).

Terraform can be used to codify the configuration for software defined networks.
Terraform interacts and takes care of communication with control layer APIs with ease. You just use the HCL language to declare your infrastructure regardless of where you're deploying.

Terraform is cloud-agnostic. This means it's not bound to one cloud. It support a vast array of private and public cloud vendors.

Terraform tracks state of each resource deployed. Terraform's state tracking mechanism takes away the worry of dependency and resource tracking by keeping it all in one place.




---
## INFRASTRUCTURE AS CODE WITH TERRAFORM
### TERRAFORM WORKFLOW
The core Terraform workflow: `Write -> Plan -> Apply`

#### WRITE STEP:
In this stage you write your Terraform configuration just like you write code. This would generally start off with creating a GitHub repo as a common best practice.

As you make progress on authoring your config, repeatedly running plans can help flush out syntax errors and ensure that your config is coming together as expected.


#### PLAN STEP:
In this stage you will continually add and review changes to code in your project.

When the feedback loop of the *Write* step has yielded a change that looks good, it's time to commit your work and review the final plan.

Because `terraform apply` will display a plan for confirmation before proceeding to change any infrastructure, that's the command you run for final review.


#### APPLY STEP:
This is the deploy of your IaC. After one last review/plan, you'll be ready to provision real infrastructure.
At this point, it's common to push your version control repository to a remote location for safekeeping.


> #### NOTES:
> - This core workflow is a loop. The next time you want to make changes, you start the process over from the beginning.



### TERRAFORM INIT:
`terraform init` is the command that initializes the working directory that contains your Terraform code.
`terraform init` is the first command that you'll be running when you're done writing your initial code.
It can either go and download the plugins and modules from the Terraform public registry over the internet, or from your custom URLs where you might have uploaded your custom modules written for Terraform.

#### PROCESS IN `terraform init`:
1. **Download ancillary components:** It downloads modules and plugins required for your code to work. This includes the providers, and modules.

2. **Set up backend:** It sets up the backend for storing Terraform state file, a mechanism by which Terraform tracks resources.



### TERRAFORM KEY CONCEPTS: PLAN, APPLY, AND DESTROY
#### PLAN:
Reviewing your Terraform code: `terraform plan`.
The `terraform plan` command reads the code and then creates and shows a plan of execution/deployment.
This command doesn't deploy anything. Consider this a read-only command.
It allows the user to review the action plan before executing anything.
At this stage, authentication credentials are used to connect to your infrastructure, if required.


#### APPLY:
Deploying your Terraform code: `terraform apply`.
The `terraform apply` is the final command that you'll be running. It deploy the instructions and statements in the code into the form of actual infrastructure.
It updates the deployment state tracking mechanism file, a.k.a *state file*. Normally, the *state file* is stored locally or can also be stored remotely in a few other cloud resources.
By default, the name of the *state file* is `terraform.tfstate`. However, this can be changed.


#### DESTROY:
Cleaning up your Terraform deployment: `terraform destroy`.
The `terraform destroy` command looks at the recorded, stored state file created during deployment, and destroys all resources created by your code.
This should be used with caution, as it's a non-reversible command. Take backups, and be sure that you want to delete the infrastructure.
This is for cleaning up, or deleting infrastructure created and tracked by Terraform.



### RESOURCE ADDRESSING IN TERRAFORM: UNDERSTANDING TERRAFORM CODE
#### CONFIGURING A PROVIDER:
```
provider "aws" {
  region = "us-east-1"
}
```

In this snippet, the word `provider` is a reserved keyword that specifies the next block of code refers to a provider.
The word `aws` refers to the name of the provider to be used.
Everything inside the curly braces (`{}`) refers to the configuration parameters.


#### CONFIGURING A RESOURCE:
```
resource "aws_instance" "web" {
  ami           = "ami-a1b2c3d4"
  instance_type = "t2.micro"
}
```

In this snippet, the word `resource` is a reserved keyword that specifies the next block of code refers to a resource.
`aws_instance` refers to the type of resource that the provider supports (EC2 instance in this case). Resource provided by Terraform provider.
`web` is a user-provided arbitrary resource name.
Everything inside the curly braces (`{}`) refers to the resource config arguments. It will change depending of the resource being created.

**Referencing resources in code:**

To access to a resource within your Terraform code, you would use the next structure: `resource_type.resource_name`. Example:
```
aws_instance.web
```

### CONFIGURING DATA SOURCE:
```
data "aws_instance" "my-vm" {
  instance_id = "i-1234567890abcdef1"
}
```

With a data source, Terraform fetches data of an already existing resource environment.
`data` is the reserved keyword that specified the next block of code is for a data source.
`aws_instance` refers to the resource type provided by Terraform provider.
`my-vm` refers to the user-provided arbitrary resource name.
Within the curly braces (`{}`) you have the arguments for the data source.
The main difference between a data source block and a resource block is that data source block is fetching and tracking details of an already existing resource, whereas a resource block creates a resource from scratch.

**Referencing data sources in code:**

To access to a data source within your Terraform code, you would use the next structure: `data.resource_type.resource_name`. Example:
```
data.aws_instance.my-vm
```

#### TERRAFORM CODE EXECUTION:
Terraform executes code in the following order:

1. It executes code in files with the `.tf` extension.
2. Internally, Terraform looks for providers in the [Terraform providers registry](https://registry.terraform.io/browse/providers). But they can also be sourced locally or internally and referenced within your code.




---
## TERRAFORM FUNDAMENTALS
### INSTALLING TERRAFORM & TERRAFORM PROVIDERS
#### INSTALLING TERRAFORM:
There are 2 methods to install Terraform:
- Download the single binary file (download, unzip, use). If needed, set the binary path into the PATH environment variable.
- Set up the Terraform repository and install it via your package manager (Linux only).
More info can be found [here](https://learn.hashicorp.com/tutorials/terraform/install-cli).


#### TERRAFORM PROVIDERS:
Providers are Terraform's way of abstracting integration with API control layer of the infrastructure vendors. Every cloud vendor has its own provider.
Terraform, by default, looks for Providers in the [Terraform providers registry](https://registry.terraform.io/browse/providers). However, providers can also be sourced locally or internally and referenced within your code.
Providers are plugins. They are released on a separate rhythm from Terraform itself, and each provider has its own series of version numbers.
You can write your own custom providers as well.

Terraform finds and install providers when initializing working directory (terraform init).
As a best practice, providers should be pegged down to a specific version in your code. So that any changes across provider versions don't break your Terraform code.
If you don't specify the provider's version in your code, it will select the latest version.


> #### NOTES:
> You can set an alias to a provider to specify it later on a resource. This if you are working with multiple providers:
> ```
> provider "aws" {
>   alias  = "us-east-1"
>   region = "us-east-1"
> }
> 
> provider "aws" {
>   alias  = "us-west-2"
>   region = "us-west-2"
> }
>
> resource "aws_sns_topic" "topic-us-east" {
>   provider = aws.us-east-1
>   name     = "topic-us-east"
> }
>
> resource "aws_sns_topic" "topic-us-west" {
>   provider = aws.us-west-1
>   name     = "topic-us-west"
> }
> ```



### TERRAFORM STATE: THE CONCEPT:
The main reason Terraform uses states is for resource tracking.
State is a way for Terraform to keep tabs on what has been deployed, and it's critical to Terraform functionality.
It helps Terraform to calculate deployment delta and create new deployment plans.

The *state file* is what help Terraform to map the resources in your code to the actual infrastructure deployed.
This file is a JSON dump containing all the metadata about your Terraform deployment, as well as details about all the resources that it has deployed.
By default, it's named `terraform.tfstate`

Because the state file is so critical to Terraform's functionality, never lose it. If you lose it, you won't have a codified way to go back and make changes to your infrastructure.
Also, don't let it fall into wrong hands since it contains sensitive data and details about the resources deployed through Terraform.


### TERRAFORM VARIABLES & OUTPUTS
#### VARIABLES:
To reference a variable within your code, you use the following notation `var.var_name`. Example:
```
var.my-variable
```

Although variables can be on the same main file (where your code is), best practice is to have a separate file for variables. This file is called 'terraform.tfvars'

The variable precedence at runtime is as follows:
1. Variable passed to the OS environment variables.
3. Passed via the command line.
2. terraform.tfvars file.


#### VARIABLE SNIPPET STRUCTURE:
```
variable "my-variable" {
  description = "This is a test variable"
  type        = string
  default     = "Hello"
}
```

In this snippet, `variable` is a Terraform reserved word used to specify a variable.
`my-var` is the name of the variable itself.
Everything inside the curly braces (`{}`) are the variable config arguments such as type of variable and default value. This information is optional.


#### VARIABLE VALIDATION:
Variable validation allows you to set a criteria for allowed values for a variable. Example:
```
variable "my-variable" {
  description = "This is a test variable"
  type        = string
  default     = "Hello"

  validation {
    condition     = length(var.my-var) > 4                          # Validation is that the variable character length must be greater than 4.
    error_message = "This string must be more than 4 characters."   # If validation is not met, this error message is thrown.
  }
}
```

If validations are not met, Terraform will stop before it deploys anything. This feature is available on version `0.13` and later.


#### VARIABLE SENSITIVE VALUES:
You can enable a config parameter known as 'sensitive' to prevent Terraform from showing its value during Terraform execution runs. This is the default behavior with Terraform.
The sensitive parameter is a boolean value, which means it can be either `true` of `false`. By default is `false`. Example:
```
variable "my-variable" {
  description = "This is a test variable"
  type        = string
  default     = "Hello"
  sensitive   = true
}
```


#### VARIABLE TYPES:
**Base types:**
There are 3 base variable types for Terraform variables:
- string: For characters or string of characters. In this case the value is inside double quotes.
- number: For numbers.
- bool: For Boolean values ('true' or 'false').

**Complex types:**
There are 5 complex variable types for Terraform variables:
- list.
- set.
- map.
- object.
- tuple.

> Refer to example project [variable-types](projects/examples/variable-types) for examples for the different variable declaration.


#### TERRAFORM OUTPUT - OUTPUT VARIABLES:
Output variables are shown on the shell after running `terraform apply` command.
You can use the same sensitive setting argument for an output as you can with a Terraform variable if it's a secret value.
Output values are like return values that you want to track after a successful Terraform deployment.


#### OUTPUT VARIABLES SNIPPET STRUCTURE:
```
output "instance_ip" {
  description = "VM private IP"
  value = aws_instance.my-vm.private_ip
}
```

In this snippet, `output` is a Terraform reserved word used to specify an output variable.
`instance_ip` is the name of the output variable specified by the user.
Everything inside the curly braces ({}) are the variable config arguments, such as variable description and value.
The only mandatory argument is the `value` argument and can be set with any value, or even reference values of other Terraform resources and variables.


### TERRAFORM PROVISIONERS
Terraform Provisioners are Terraform's way of bootstrapping custom scripts, command or actions.
They can be run either locally (on the same system where Terraform commands are being issued from), or remotely on resources spun up through the Terraform deployment.
Within Terraform code, each individual Resource can have its own Provisioner defining the connection method (if required such as SSH or WinRM) and the actions/commands or script to execute.


#### TYPES OF PROVISIONERS:
There are 2 types of Provisioners that cover 2 events of your Terraform resource lifecycle. They can come in handy with custom one-off automation tasks:

- **Creation-time:** This Provisioner is run as a resource has been created. This is the default.
- **Destroy-time:** This Provisioner is run as a resource is destroyed.

#### BEST PRACTICES & CAUTIONS WHEN USING PROVISIONERS:
Hashicorp recommends using Provisioners as a last resource and to try using inherent mechanisms within your infrastructure deployment to carry out custom tasks where possible.
Terraform cannot track changes to Provisioners as they can take any independent action, hence they are not tracked by Terraform *state files*.
Provisioners are recommended for use when you want to invoke actions not covered by Terraform declarative model.
If the command within a Provisioner returns non-zero return code, it's considered failed and underlying resource is tainted (it marks the resource against which the Provisioner was to be run, to be created again on the next one).

> #### NOTES:
> - By default, a Provisioner is a *create provisioner*. If you want to specify a *Destroy Provisioner* you need to explicitly set the Provisioner parameter `when` to `destroy`: `when = destroy`.
> - You can use multiple Provisioners against the same resource, and they are going to be executed in the same sequence as they're written out.
> - Provisioners aren't tracked and are independent from Terraform state file. Which means, it won't show in a Terraform Plan.
> - For using variables inside Provisioners, Hashicorp has provided the `self` object. This object can access any attribute available to the Resource that the Provisioner is attached to. Example: `self.id`.




---
## TERRAFORM STATE
Terraform state is an important aspect of Terraform, since it allows the tracking of the infrastructure. It maps real-world resources to Terraform configuration.
By default, state is stored locally in a file called `terraform.tfstate`, but it can be stored remotely in services such as AWS S3.

Prior to any modification operation, Terraform refreshes the state file. Resource dependency metadata is also tracked via the state file. For example, Terraform must know that it needs to configure a subnet before it can deploy a VM in the AWS cloud.
The state file also helps to boost deployment performance by caching resource attributes for subsequent use.


### `terraform state` COMMAND
The `terraform state` command is an utility for manipulating and reading the Terraform state file. Usually, there is no need for managing the state file outside of the Terraform plan/apply workflow. But some case scenarios are:
- Advanced state management.
- Manually remove a resource from terraform state file so that it's not managed by Terraform.
- Listing out tracked resources and their details (via state and list subcommands).


#### COMMON TERRAFORM STATE COMMANDS:
- List out all resources tracked by the Terraform State file:
  ```
  terraform state list
  ```

- Delete a resource from the Terraform State file:
  ```
  terraform state rm
  ```

- Show details of a resource tracked in the Terraform State file:
  ```
  terraform state show
  ```



### LOCAL & REMOTE STATE STORAGE
Terraform generally saves state files locally. That means that it's stored on the same system from where you are issuing the Terraform commands. This is the default behavior. This is mostly used for individual projects or testing.
As a fail-safe, Terraform does back up your last known Terraform state file recorded after a successful `terraform apply` locally.

#### REMOTE STAGE STORAGE:
The remote stage storage mechanism saves the state file to a remote data source (AWS S3, Google Storage, etc). However, this is optional.
The main advantages of working with remote storage are:
  - It allows sharing state file between distributed teams.
  - State locking: It allows locking the state file so parallel executions don't collide. Keep in mind state locking is not supported on all remote storage backend.
  - It enables sharing *output* values with other Terraform configuration or code.




---
## TERRAFORM MODULES
A module in Terraform is just another folder or collection of Terraform code files. And you reference the outputs of that code into other parts of your Terraform project.
A module is a container for multiple resources that are used together.


### ACCESSING AND USING TERRAFORM MODULES
The main purpose of the modules is to make code reusable elsewhere so that you don't have to duplicate code/configurations.

Every Terraform configuration has at least one module, called the `root` module, which consists of code files in your main working directory.
When you invoke other modules inside your code, these newly referenced modules are known as child modules, and you can pass inputs to and get outputs back from these child modules.


#### ACCESSING TERRAFORM MODULES:
Modules can be downloaded or referenced from:
- **Terraform Public Registry**: Terraform downloads them and place them in a directory on your system. Usually, that directory is a hidden directory.
- **A private registry**: You reference the same way as the Public Registry.
- **Your local system**: You reference the modules directory by its path.

Modules are referenced using the `module` block:
```
module "my-vpc-module" {
  source = "./modules/vpc"
  version = "0.0.5"
  region = var.region
}
```
In this example:
- `module` is a reserved keyword.
- `my-vpc-module` is the module name.
- Parameters within the curly braces are `source` of the module, its `version` to be used, and the inputs for the module.

Other parameters allowed inside the `module` block include:
  - `count`: Allows spawning multiple separate instances of the module's resources.
  - `for_each`: Allows iterating over complex variables.
  - `providers`: Allows to tie down specific providers to your module.
  - `depends_on`: Allows you to set dependencies for your module.


#### USING TERRAFORM MODULES:
Modules can optionally take input and provide outputs to plug back into your main code.

Accessing module outputs in your code:
```
resource "aws_instance" "my-vpc-module" {
  ... # Other arguments.
  subnet_id = module.my-vpc-module.subnet_id
}
```
In this example, `module.my-vpc-module.subnet_id` is the module's output.



### INTERACTING WITH TERRAFORM MODULE INPUTS AND OUTPUTS
#### TERRAFORM MODULE INPUTS:
Module inputs are arbitrarily named *parameters* that you can pass inside the module block.
These inputs can be used as variables inside the module code.

Example of specifying an input parameter from the root module:
```
module "my-vpc-module" {
  source = ".modules/vpc"
  server-name = 'my-server'   # This is the input parameter.
}
```
In this case, inside the module definition, you would use the input parameter as a variable in the form of `var.server-name`.


#### TERRAFORM MODULE OUTPUTS:
The outputs declared inside Terraform module code can be fed back into the root module or your main code.

Output invocation convention in Terraform code:
```
module.<name-of-module>.<name-of-output>
```
Keep in mind that this output is declared using the `output` block in Terraform.

**Example**:

Inside your module code:
```
output "ip_address" {
  value = aws_instance.private_ip
}
```

Referencing the module output in the main code:
```
module.my-vpc-module.ip_address
```




---
## BUILT-IN FUNCTIONS AND DYNAMIC BLOCKS
### TERRAFORM BUILT-IN FUNCTIONS
Terraform comes pre-packaged with functions to help you transform and combine values. You don't need any additional provisioners or providers to use these functions. User-defined functions are not allowed (only built-in ones). You can use these functions inside various places in your terraform code. Built-in functions are extremely useful in making Terraform code dynamic and flexible.

General syntax:
```
function_name(arg1, arg2, ...)
```

A list of useful Terraform functions can be found [here](https://www.terraform.io/docs/language/functions/index.html). A few examples are:

- `file`: Allows you to insert files into your resources where applicable.
- `max`: Determines the max integer value from provided list.
- `flatten`: Creates a singular list of a provided set of lists.


#### `terraform console` COMMAND:
The `terraform console` command provides an interactive console for evaluating expressions. If the current state of your deployment is empty or has not yet been created, the console can be used to experiment with expression syntax and build-in functions.

When you execute `terraform console` it will execute the interactive CLI for testing built-in functions.

Examples:
```
terraform console
> contains(["my", "test", 1, 2, 3], "1")
false
> contains(["my", "test", 1, 2, 3], 1)
true
> max(0, 1, 9, 2, 5)
9
> timestamp()
"2021-11-06T23:18:54Z"
> join("-", ["my", "test"])
"my-test"
> exit

```



### TERRAFORM TYPE CONSTRAINTS (COLLECTIONS & STRUCTURAL)
Terraform type constraints control the type of variable values that you can pass to your Terraform code. Essentially, there are 2 types of constraints:
- **Primitive types**: For single type values (`number`, `string`, `bool`).
- **Complex types**: For multiple types in a single variable (`list`, `tuple`, `map`, `object`). These complex types can be broken into 2 further types (`collections`, and `structural`).

#### COMPLEX TYPES - COLLECTIONS:
Collections types allow multiple values of one primitive type be grouped together. You cannot mix more than one type against a single variable. Constructors for these Collections include:
- `list(type)`.
- `map(type)`.
- `set(type)`.

Example:
```
variable "training" {
  type = list(string)
  default = ["first", "second"]
}
```


#### COMPLEX TYPES - STRUCTURAL:
Structural types allow multiple values of different primitive types to be grouped together. Constructors for these include:
- `object(type)`.
- `tuple(type)`.
- `set(type)`.

Example:
```
  variable "person" {
    type = object({
      name = string
      age = number
    })
  }
```


#### DYNAMIC TYPES - THE `any` CONSTRAINT:
`any` is a placeholder for a primitive type yet to be decided. Terraform makes a best effort to attempt to figure it out what kind of variable you've passed and assign it a proper primitive type. The actual type will be determined at runtime.

Example:
```
variable "data" {
  type = list(any)
  default = [42, 7, 13]
}
```



### TERRAFORM DYNAMIC BLOCKS:
Dynamic blocks help to dynamically constructs repeatable nested configuration blocks inside Terraform resources. They are supported within the following block types:
- resource.
- data.
- provider.
- provisioner.

Dynamic blocks expect a complex variable type to iterate over.
It acts like a `for` loop and outputs a nested block for each element in your variable.

Be careful not to overuse dynamic blocks in your main code, as they can be hard to read/maintain.
Only use dynamic blocks when you need to hide detail in order to build a cleaner user interface when writing reusable modules.

> Refer to example project [built-in-funcs-and-dynamic-blocks](projects/examples/built-in-funcs-and-dynamic-blocks) for examples of dynamic blocks & built-in functions.


---
## TERRAFORM CLI




---
## TERRAFORM CLOUD & ENTERPRISE




---
## MISCELLANEOUS
### COMMANDS
#### GENERAL:
```
terraform init                  # Initialize the working directory containing the Terraform code.
terraform plan                  # Read Terraform code and create & display a plan for execution/deployment.
terraform apply                 # Deploys the instructions and statements (code) into the form of actual infrastructure. It also creates a last review/plan.
terraform apply --auto-approve  # Deploys the instructions and statements (code) into the form of actual infrastructure. It won't create a review/plan.
terraform destroy               # Destroys all the actual resources created by your code.
terraform console               # Executes the interactive Terraform CLI (useful for evaluating expressions).
```


#### TERRAFORM STATE:
```
terraform state list            # List out all resources tracked by the Terraform State file.
terraform state show <RESOURCE> # Show details of a resource tracked in the Terraform State file.
terraform state rm <RESOURCE>   # Delete a resource from the Terraform State file.
```



### FILES, DIRECTORIES, ENVIRONMENT VARIABLES
#### ENVIRONMENT VARIABLES:
```
TF_LOG                  # Environment variable that controls the level of logging with Terraform (the verbosity). To review log you can set this to 'TRACE'.
```

#### FILES:
```
FILENAME.tf             # Terraform code file.
terraform.tfstate       # Default file name of the state file.
terraform.tfvars        # Default file for variables.
```

#### DIRECTORIES:


### MISCELLANEOUS
