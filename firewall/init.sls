http:
    cmd.run:
        - name: iptables -A PREROUTING -t nat -i eth0 -p tcp --dport 80 -j REDIRECT --to-port 8080
#http:
#    iptables.append:
#        - chain: PREROUTING
#        - interface: eth0
#        - table: nat
#        - jump: REDIRECT
#        - dport: 80
#        - proto: tcp
#        - to-ports: 8080
