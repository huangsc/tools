#!/bin/bash -xv
# -xv shell脚本调试之用 这个参数也可以去掉

go env -w GOPROXY='https://goproxy.io' #加快 go mod 下载速度
echo '输入你私有仓库的host name eg: git.mojotv.corp.net >'

read GOPRIVATE

go env -w GOPRIVATE=$GOPRIVATE

echo '输入你的私有仓库的UserName用户名 >'

read GIT_USER
echo "访问你 https://$GOPRIVATE/profile/personal_access_tokens 创建个人访问令牌,填写gitlab-access-token >"
read GIT_TOKEN
echo '开始配置git config --global 使用access-token 验证私有仓库身份认证'
git config --global url."https://$GIT_USER:$GIT_TOKEN@$GOPRIVATE".insteadOf "https://$GOPRIVATE"
echo '现在你可以使用 go mod download (go run main.go) 继续开发你的项目了'
