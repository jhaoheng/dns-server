$TTL    604800
@       IN      SOA     ns1.default.com. root.default.com. (
                  3       ; Serial
             604800     ; Refresh
              86400     ; Retry
            2419200     ; Expire
             604800 )   ; Negative Cache TTL
;
; name servers - NS records
     IN      NS      ns1.default.com.

; name servers - A records
ns1.default.com.                       IN      A      172.20.0.2

nginx-dockerip.default.com.            IN      A      172.20.0.3
nginx.default.com.                     IN      A      10.0.1.3