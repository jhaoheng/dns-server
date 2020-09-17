# 參考文章 
- https://www.digitalocean.com/community/tutorials/how-to-configure-bind-as-a-private-network-dns-server-on-ubuntu-14-04
- https://www.howtoforge.com/two_in_one_dns_bind9_views

# 目的
- 透過 docker 建立 dns-server, 並可以從外部網路連線 dns-server 進行判斷
- 範例是
    - dns-server = $yourComputerIP:53/udp
    - nginx = $yourComputerIP:80
- 範例中的 $yourComputerIP = 10.0.1.3, 請替換掉

# 設定步驟
1. 建立 zones file, ex: `default.com`
    - [ ] : 確定 DomainName
    - [ ] : 確定 ip, ex:10.0.1.3, 請確定該 ip 位置防火牆有關閉
2. 更新 `named.conf.local`, 
    - [ ] : 設定 zone 的 DomainName
    - [ ] : 設定 zone file 位置
3. 建立 docker 環境
    - `docker build -t bind9 .`
    - `docker-compose up -d`
4. 執行 dns-server : `docker exec dns-server /etc/init.d/bind9 start`

# 測試
- 測試 dns server
    - `host nginx-dockerip.default.com. 10.0.1.3`: 會顯示 172.20.0.3
    - `host nginx.default.com 10.0.1.3` : 會顯示你指定的 ip 位置
- 用 browser 測試
    1. 在 wifi 中, 設定 dns server 為本機 ip
    2. 開啟 browser, 輸入 nginx.max.com
- 在手機端
    1. 連線到 wifi, 同一個區域網路
    2. 更新 dns = 10.0.1.3
    3. 重新連線 wifi
    4. 在手機端輸入 nginx.max.com



