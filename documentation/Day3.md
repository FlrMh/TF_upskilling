## DRY with Terraform (Don`t repeat yourself)

1. Variables
2. Modules

---

# 1. Variables:

- Input variables let you customize aspects of Terraform modules without altering the module's own source code. This functionality allows you to share modules across different Terraform configurations, making your module composable and reusable.

When you declare variables in the root module of your configuration, you can set their values using CLI options and environment variables. When you declare them in child modules, the calling module should pass values in the module block.

- If you're familiar with traditional programming languages, it can be useful to compare Terraform modules to function definitions:

    Input variables are like function arguments.
    Output values are like function return values.
    Local values are like a function's temporary local variables.

Note: For brevity, input variables are often referred to as just "variables" or "Terraform variables" when it is clear from context what sort of variable is being discussed. Other kinds of variables in Terraform include environment variables (set by the shell where Terraform runs) and expression variables (used to indirectly represent a value in an expression).

Declaring an Input Variable

Each input variable accepted by a module must be declared using a variable block:
```HCL
variable "name-given-to-variable" {
    default = "<deault value>"
    type = string/number/bool/list


}
```
The label after the variable keyword is a name for the variable, which must be unique among all variables in the same module. This name is used to assign a value to the variable from outside and to reference the variable's value from within the module.
The name of a variable can be any valid identifier except the following: source, version, providers, count, for_each, lifecycle, depends_on, locals. These names are reserved for meta-arguments in module configuration blocks, and cannot be declared as variable names.


Terraform CLI defines the following optional arguments for variable declarations:

    default - A default value which then makes the variable optional.
    type - This argument specifies what value types are accepted for the variable.
    description - This specifies the input variable's documentation.
    validation - A block to define validation rules, usually in addition to type constraints.
    sensitive - Limits Terraform UI output when the variable is used in configuration.
    nullable - Specify if the variable can be null within the module.

----

# 2. Modules:










---

**Automating creation of resources (without interruption of inputs in terminal (e.g. in terraform apply having to input yes or no)) - use the --auto-approve flag (NOT TO BE USED IN PRODUCTION).