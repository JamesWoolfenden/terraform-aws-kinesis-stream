# terraform-aws-kinesis-stream

This has an example for how to add a custom Checkov check:
Create a folder for your checks:

```cli
$ mkdir checkov
...
```

Add __init__.py

```python
from os.path import dirname, basename, isfile, join
import glob
modules = glob.glob(join(dirname(__file__), "*.py"))
__all__ = [ basename(f)[:-3] for f in modules if isfile(f) and not f.endswith('__init__.py')]
```

And your resource check **checkov\KinesisStreamEncryptionType.py**:

```python
from checkov.common.models.enums import CheckResult, CheckCategories
from checkov.terraform.checks.resource.base_resource_check import BaseResourceCheck


class KinesisStreamEncryptionType(BaseResourceCheck):
    def __init__(self):
        name = "Ensure Kinesis Stream is securely encrypted"
        id = "CKV_AWS_999"
        supported_resources = ['aws_kinesis_stream']
        categories = [CheckCategories.ENCRYPTION]
        super().__init__(name=name, id=id, categories=categories, supported_resources=supported_resources)

    def scan_resource_conf(self, conf):
        if "encryption_type" in conf.keys():
            if (conf["encryption_type"][0] == "KMS"):
                return CheckResult.PASSED
            else:
                return CheckResult.FAILED
        else:
            return CheckResult.FAILED



check = KinesisStreamEncryptionType()
```
And finally run your new check:
```cli
$ checkov -d . --external-checks-dir checkov/
...
```
