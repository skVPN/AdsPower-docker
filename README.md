# AdsPower Docker 容器

## 使用方法

1. 将 `adspower.deb` 文件放在项目根目录
2. 构建并启动容器：
   ```bash
   docker-compose up -d
   ```
3. 访问 http://localhost:8080 使用 noVNC 连接桌面

## 端口说明
- 8080: noVNC Web界面
- 5900: VNC直连端口