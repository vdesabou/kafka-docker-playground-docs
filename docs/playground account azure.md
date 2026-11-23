# playground account azure

☁️ Set up an Azure subscription for the Azure examples, and check it

- **setup**: a service principal for the examples (no browser login on every run), resource providers
- **check**: verify that the stored service principal logs in, its roles, the resource providers

Every Azure example creates its own resource group and deletes it at the  
end: what they need is a login allowed to do it. Without a service  
principal, each run opens the browser for 'az login'.

📖 Step by step guide (subscription, roles, what each example needs, troubleshooting):  
https://kafka-docker-playground.io/#/azure

## Usage

```bash
playground account azure COMMAND
```

## Commands

- [check](playground%20account%20azure%20check) - 🩺 Check that the stored Azure service principal works for the Azure examples
- [setup](playground%20account%20azure%20setup) - 🛠️ Configure an Azure subscription for the Azure examples


