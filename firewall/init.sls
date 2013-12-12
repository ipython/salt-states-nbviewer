# iptables -A PREROUTING -t nat -i eth0 -p tcp --dport 80 -j REDIRECT --to-port 8080

http:
    iptables.append:
        - chain: PREROUTING
        - table: nat
        - in-interface: eth+
        - proto: tcp
        - dport: 80
        - jump: REDIRECT
        - to-ports: 8080
        - save: True
