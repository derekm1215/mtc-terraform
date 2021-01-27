#!/bin/bash
sudo hostnamectl set-hostname plantcmd-${nodename} &&
curl -sfL https://get.k3s.io | sh -s - server \
--datastore-endpoint="mysql://admin:w1r3fu1d8@tcp(${db_endpoint})/rancher" \
--write-kubeconfig-mode 644
{{!--curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash &&--}}
{{!--export KUBECONFIG=/etc/rancher/k3s/k3s.yaml &&--}}
{{!--sudo helm repo add rancher-stable https://releases.rancher.com/server-charts/stable &&--}}
{{!--sudo kubectl create namespace cattle-system &&--}}
{{!--sudo helm install rancher rancher-stable/rancher \--}}
{{!----namespace cattle-system --set hostname=${lb_endpoint} --set tls=external \--}}
{{!----kubeconfig /etc/rancher/k3s/k3s.yaml \--}}
{{!----set antiAffinity=required--}}