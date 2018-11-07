Firewall防护墙

       iptables [-t table] {-A|-C|-D} chain rule-specification

       ip6tables [-t table] {-A|-C|-D} chain rule-specification

       iptables [-t table] -I chain [rulenum] rule-specification

       iptables [-t table] -R chain rulenum rule-specification

       iptables [-t table] -D chain rulenum

       iptables [-t table] -S [chain [rulenum]]

       iptables [-t table] {-F|-L|-Z} [chain [rulenum]] [options...]

       iptables [-t table] -N chain

       iptables [-t table] -X [chain]

       iptables [-t table] -P chain target

       iptables [-t table] -E old-chain-name new-chain-name

链管理:
    -F:flush ,清除规则链;省略链,表示清空制定表上的所有链
    
    -N new,创建新的自定义规则链
    -Z zero 清零,置零规则计数器