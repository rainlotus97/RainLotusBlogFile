if [ ! $1 ]
then
    echo "####### 请输入commit值 #######"
    exit;
fi

echo "####### 确保在项目根目录打开 #######"

ls

echo "####### 拉取最新代码 #######"

git pull origin master

echo "####### 添加文件 #######"

git add .

git status

sleep 1s

echo "####### commit #######"

git commit -m "$1" --no-verify

sleep 1s

echo "####### 开始推送 #######"


git push -f origin master

echo "####### 推送成功 #######"

sleep 1s

echo "####### 开始推送博客 #######"

hexo clean

sleep 1s

hexo g -d

echo "####### 推送博客结束 #######"