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

- Updating users for an HTPasswd identity provider

Retrieve the HTPasswd file from the `htpass-secret` secret object and save the file to your file system:

```
oc get secret htpass-secret -ojsonpath={.data.htpasswd} -n openshift-config | base64 --decode > users.htpasswd
```

To add a new user:

```
htpasswd -bB users.htpasswd <username> <password>
```

To remove an existing user:

```
htpasswd -D users.htpasswd <username>
```

Replace the `htpass-secret` secret object with the updated users in the `users.htpasswd` file:

```
oc create secret generic htpass-secret --from-file=htpasswd=users.htpasswd --dry-run=client -o yaml -n openshift-config | oc replace -f -
```

If you removed one or more users, you must additionally remove existing resources for each user:

```
oc delete user <username>
```

Delete the Identity object for the user:

```
oc delete identity my_htpasswd_provider:<username>
```

## Role Binding/Cluster Role Binding

- Local role binding operations:

| Command	| Description |
| --- | --- |
| oc adm policy who-can <verb> <resource> | Indicates which users can perform an action on a resource. |
| oc adm policy add-role-to-user <role> <username> | Binds a specified role to specified users in the current project. |
| oc adm policy remove-role-from-user <role> <username> | Removes a given role from specified users in the current project. |
| oc adm policy remove-user <username> | Removes specified users and all of their roles in the current project. |
| oc adm policy add-role-to-group <role> <groupname> | Binds a given role to specified groups in the current project. |
| oc adm policy remove-role-from-group <role> <groupname> | Removes a given role from specified groups in the current project. |
| oc adm policy remove-group <groupname> | Removes specified groups and all of their roles in the current project. |

- Cluster role binding operations

| Command | Description |
| --- | --- |
| oc adm policy add-cluster-role-to-user <role> <username> | Binds a given role to specified users for all projects in the cluster. |
| oc adm policy remove-cluster-role-from-user <role> <username> | Removes a given role from specified users for all projects in the cluster. |
| oc adm policy add-cluster-role-to-group <role> <groupname> | Binds a given role to specified groups for all projects in the cluster. |
| oc adm policy remove-cluster-role-from-group <role> <groupname> | Removes a given role from specified groups for all projects in the cluster. |

- Define the user as a cluster admin:

```
oc adm policy add-cluster-role-to-user cluster-admin <user>
```