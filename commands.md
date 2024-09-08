### Setup and Commands

1. **Minikube Setup**
   - `create minikube cluster`
   - `minikube start`
   - `minikube status`

2. **Cluster Info & Configuration**
   - `kubectl version`
   - `kubectl get nodes`
   - `kubectl config get-contexts`
   - `kubectl config current-context`
   - `kubectl config set-context --current --namespace infoxapps`
   - `kubectl config view --minify | grep namespace:`
   - `kubectl config view --minify --output 'jsonpath={..namespace}'`

3. **Namespace Management**
   - `kubectl create namespace infoxapps`
   - `kubectl get namespace`

4. **Deployments**
   - `kubectl create deployment nginx-depl --image=nginx`
   - `kubectl get deployment`
   - `kubectl edit deployment nginx-depl`
   - `kubectl delete deployment mongo-depl`
   - `kubectl delete deployment nginx-depl`

5. **Pods, Replicasets, and Services**
   - `kubectl get pod`
   - `kubectl get replicaset`
   - `kubectl get services`

6. **Deployment with Config Files**
   - `vim nginx-deployment.yaml`
   - `kubectl apply -f nginx-deployment.yaml`
   - `kubectl delete -f nginx-deployment.yaml`

7. **Debugging and Logs**
   - `kubectl logs {pod-name}`
   - `kubectl exec -it {pod-name} -- bin/bash`

8. **Metrics**
   - `kubectl top`

---

### Helm Commands

1. **Install Chart**:
   - `helm install [RELEASE_NAME] [CHART]`

2. **Upgrade Release**:
   - `helm upgrade [RELEASE_NAME] [CHART]`

3. **Uninstall Release**:
   - `helm uninstall [RELEASE_NAME]`

4. **List Releases**:
   - `helm list --namespace [NAMESPACE]`

5. **Repo Management**:
   - `helm repo add [REPO_NAME] [URL]`
   - `helm repo update`

6. **Chart Info and Status**:
   - `helm search repo [KEYWORD]`
   - `helm show [values|chart|readme] [CHART]`
   - `helm status [RELEASE_NAME]`
   - `helm get all [RELEASE_NAME]`

7. **Templates and Linting**:
   - `helm template [RELEASE_NAME] [CHART]`
   - `helm lint [CHART_PATH]`
   - `helm package [CHART_PATH]`

8. **Rollback**:
   - `helm rollback [RELEASE_NAME] [REVISION]`

---

### TMUX Commands

- `tmux ls`
- `tmux new-session -s session-name`
- `tmux attach-session -t session-name`
- `tmux kill-session -t target-session`
- `CTRL-B` then `D` to detach

---

### Supervisor Commands

- `supervisorctl reread`
- `supervisorctl update`
- `supervisorctl start <app>`
- `service supervisor restart`
- `service supervisor stop`
- `service supervisor start`

---

### MySQL Commands

- Connect: `mysql -h <host> -P <port> -u <username> -p<password>`
- Backup: `mysqldump -u [username] -p[password] [database_name] > [dump_file.sql]`
- Restore: `mysql -u [username] -p[password] [database_name] < [dump_file.sql]`

---

### ZIP & Rsync

- Zip: `zip -r output_file.zip file1 folder1`
- Tar Compress: `tar -zcvf file.tar.gz folder`
- Tar Decompress: `tar -xf file.tar.gz`
- Rsync: `rsync -aP /SourceDirectory/ username@192.168.56.100:/Destination`

---

### Nginx Commands

- Start: `sudo nginx`
- Stop: `sudo nginx -s stop`
- Restart:
   - Mac: `sudo nginx -s stop && sudo nginx`
   - Linux: `sudo systemctl restart nginx`
