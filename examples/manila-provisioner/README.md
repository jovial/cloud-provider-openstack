# How to mount Ceph Manila Share using OpenStack credentials

## Preconditions

- A working Kubernetes cluster
- Manila share with a Ceph backend

First of all, generate `secrets.yml` manifest containing your OpenStack
credentials. Ensure that your OpenStack environment variables are sourced and
that you can interact with OpenStack API normally. Ignore the warning about
`OS_USER_ID` not being set.

```bash
$ source ~/p3-openrc.sh
$ ./generate-secrets.sh -n manila-secrets | ./filter-secrets.sh > secrets.yaml

Your `secrets.yml` should looks something like this. It is base64 encoded hence
the characters look jumbled up.

    apiVersion: v1
    kind: Secret
    metadata:
      name: manila-secrets
      namespace: default
    data:
      os-authURL: "aHR0cDovLzEwLjYwLjI1My4xOjUwMDAvdjM="
      os-userName: "YmhhcmF0"
      os-password: "YWFuZ2asdDsFtasSSDsdsA4Eh"
      os-projectID: "NTYzOGU4NTc3YmM4NDM3OWJhYmE0YmZiNjYxNzcwODY="
      os-domainName: "RGVmYXVsdA=="
      os-region: "UmVnaW9uT25l"


To add this as a secret to Kubernetes called `manila-secrets`, run this:

```bash
$ kubectl create -f secrets.yml
```

Now run `base-deploy.sh` to create necessary serviceaccounts with rbac and
underlying `manila-provisioner` deployment:

```bash
cd cephfs
./base-deploy.sh
```

Finally, run `demo-deploy.sh` OR `demo-deploy-ond.sh` to mount an existing share, e.g. `HomeDirs` or create one on-demand.

```bash
cd user-deploy
./demo-deploy.sh
```

For tearing down demos, run `demo-teardown.sh` followed by `base-teardown.sh`
