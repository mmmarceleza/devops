# Authentication and Authorization

## HTPasswd

- Install httpd-tools:

```
yum install httpd-tools
```

- Create a file with a user name and hashed password:

```
htpasswd -c -B -b </path/to/users.htpasswd> <user_name> <password>
```

- Continue to add or update credentials to the file:

```
htpasswd -B -b </path/to/users.htpasswd> <user_name> <password>
```

- Create the HTPasswd secret:

```
oc create secret generic htpass-secret --from-file=htpasswd=</path/to/users.htpasswd> -n openshift-config
```

- Create an HTPasswd identity provider:

```
apiVersion: config.openshift.io/v1
kind: OAuth
metadata:
  name: cluster
spec:
  identityProviders:
    - name: my_htpasswd_provider
      mappingMethod: claim
      type: HTPasswd
      htpasswd:
        fileData:
          name: htpass-secret
```

- Save the content above to a file (`htpasswd-oauth.yaml`) and apply it to the cluter:

```
oc apply -f </path/to/htpasswd-oauth.yaml>
```

- Log in to the cluster as a user from your identity provider, entering the password when prompted:

```
oc login -u <username>
```

- Confirm that the user logged in successfully, and display the user name:

```
oc whoami
```
