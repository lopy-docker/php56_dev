# docker-dev-php5.6-fpm

php5.6的开发环境，安装了一些常用的扩展

# 运行

## GET_START

```bash
# DOCKER_REPO 是私有仓库
docker run -v /path/to/php_project:/var/www/html DOCKER_REPO/lopy-dev/php5.6-fpm

# 当前 DOCKER_REPO 为阿里云私有库
# registry.cn-hongkong.aliyuncs.com
# registry.cn-hongkong.aliyuncs.com/lopy-dev/php5.6-fpm
docker run -v /path/to/php_project:/var/www/html registry.cn-hongkong.aliyuncs.com/lopy-dev/php5.6-fpm

# 如果某天传到docker hub了，就直接写 lopy-dev/php5.6-fpm
docker run -v /path/to/php_project:/var/www/html lopy-dev/php5.6-fpm

```

## 运行参数

### volume(-v)

* /path/to/php_project:/var/www/html

* /path/to/log:/logs

* and so on

## env(-e)
参见 [环境变量](#环境变量env) 章节

# 环境变量env

## FPM_HOST
default 127.0.0.1

## FPM_PORT
default 9000

## XDEUBG_REMOTE_HOST
default 172.17.0.1

xdebug 连接宿主机器（准确的说应该开发机器的xdebug监听服务的机器的地址）的地址

## XDEUBG_REMOTE_PORT
19001

xdebug 连接宿主机器（准确的说应该开发机器的xdebug监听服务）的端口
