# SAM Deploy Action

This action deploys AWS SAM Stacks through yaml files.

## Usage

```yml
name: "Deploy SAM Stack to Production"
on: 
  push:
    branches:
    - master

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v1
    - uses: actions/setup-node@v1
      with:
        node-version: '10.x'
    - run: for d in */ ; do cd $d && npm install --no-package-lock --loglevel=error && cd .. ; done
    - uses: university-of-york/aws-sam-deploy-action@v1.0
      env:
        TEMPLATE: 'template.yaml'
        AWS_STACK_NAME: prod-${{ github.actor }}-resourceful
        AWS_REGION: 'us-east-1'
        AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
        AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
        AWS_DEPLOY_BUCKET: ${{ secrets.AWS_DEPLOY_BUCKET }}
```

### Environment Variables

* `TEMPLATE` - [Optional]. YML file containing CloudFormation Stack.
  * Type: `string`
  * Default: `template.yaml`
* `CAPABILITIES` - [Optional]. AWS Stack Capabilites.
  * Type: `string | list[string]`
  * Syntax: e.g. `CAPABILITY_IAM` `CAPABILITY_AUTO_EXPAND`
  * Default: `CAPABILITY_IAM`
* `AWS_STACK_NAME` - [**Required**]. The Stack name that is going to be published.
  * Type: `string`
* `AWS_REGION` - [**Required**]. AWS Region where to deploy the CloudFormation Stack.
  * Type: `string`
* `AWS_ACCESS_KEY_ID` - [**Required**]. AWS Access Key Id.
  * Type: `string`
* `AWS_SECRET_ACCESS_KEY` - [**Required**]. AWS Secret Access Key.
  * Type: `string`
* `AWS_DEPLOY_BUCKET` - [**Required**]. AWS S3 Bucket where the Stack package is going to be stored.
  * Type: `string`
* `AWS_BUCKET_PREFIX` - [Optional]. S3 Bucket's folder where to upload the package.
  * Type: `string`
* `FORCE_UPLOAD` - [Optional]. Whether to override existing packages in case they are an exact match.
  * Type: `boolean`
* `USE_JSON` - [Optional]. Whether to use JSON instead of YML as the output template format.
  * Type: `boolean`
* `PARAMETER_OVERRIDES` - [Optional]. Parameters to input in the template.
  * Type: `string | list[string]`
  * Syntax: `AliasName=prod` `AliasName=prod ApiUrl=https://api.com/api/v1`
* `PARAMETER_FILE` - [Optional]. Relative path to a JSON config file. Prioritised over PARAMETER_OVERRIDES
  * Type: `string`
* `TAGS` - [Optional]. Tags to assign.
  * Type: `string | list[string]`
  * Syntax: `Environment=prod` `Name=infrastructure`
* `ROLE_ARN` - [Optional]. The full role ARN to use for the deploy step
  * Type: `string`
  
### Examples

* An implementation example can be found [here](https://github.com/r0zar/resourceful).

### License

The Dockerfile and associated scripts and documentation in this project are released under the [MIT License](LICENSE).
