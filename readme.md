# 參考文章 
- https://www.digitalocean.com/community/tutorials/how-to-configure-bind-as-a-private-network-dns-server-on-ubuntu-14-04
- https://www.howtoforge.com/two_in_one_dns_bind9_views

# 目的
- 透過 docker 建立 dns-server, 並從外部網路連線 dns-server, 進行 DomainName <-> IP 交換
- flow
    1. device set dns = dns-server-ip
    2. device request DomainName
    3. device wifi dns service -> dns-server -> get DomainName IP
    4. device use IP to access service
- 範例是
    - dns-server = $dns-server-ip:53/udp
    - nginx = $dns-server-ip:80
- 範例中的 $dns-server-ip = 10.0.1.3, 請替換掉

# 啟動服務
1. 確定 `zones/default.com` 中的 IP, 請確定防火牆關閉
    - 請更換 10.0.1.3
2. 建立 docker 環境
    - `docker build -t bind9 .`
    - `docker-compose up -d`
3. 執行 dns-server : `docker exec dns-server /etc/init.d/bind9 start`

# 測試
- 測試 dns server
    - `host nginx-dockerip.default.com. $dns-server-ip`: 會顯示 172.20.0.3
    - `host nginx.default.com $dns-server-ip` : 會顯示你指定的 ip 位置
- 用 browser 測試
    1. 在 wifi 中, 新增 dns = $dns-server-ip
    2. 開啟 browser, 輸入 nginx.default.com
- 在手機端
    1. 連線到 wifi, 同一個區域網路
    2. 新增 dns = $dns-server-ip
    3. 重新連線 wifi
    4. 在手機端輸入 nginx.default.com

# 新增 Domain Config 步驟
1. 建立 zones file
    - [ ] : 確定 DomainName, 請確定保持一致
    - [ ] : 確定 IP, ex:10.0.1.3, 請確定該 IP 防火牆關閉
2. 更新 `named.conf.local`, 
    - [ ] : 設定 zone 的 DomainName
    - [ ] : 設定 zone file 位置
3. 執行服務與測試
