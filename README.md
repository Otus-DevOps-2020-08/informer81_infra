# informer81_infra
informer81 Infra repository

задание для подключение к сомфингхосту с рабочего месте одной строкой
1. на бастионе надо выполнить следующий однострочник
sudo -- sh -c -e "echo "10.130.0.18 someinternalhost" >> /etc/hosts"
добавим в хостс запись нашего самфинг хоста
пинганем для проверки

ping someinternalhost
PING someinternalhost.ru-central1.internal (10.130.0.18) 56(84) bytes of data.
64 bytes from someinternalhost.ru-central1.internal (10.130.0.18): icmp_seq=1 ttl=63 time=11.8 ms
64 bytes from someinternalhost.ru-central1.internal (10.130.0.18): icmp_seq=2 ttl=63 time=2.93 ms
64 bytes from someinternalhost.ru-central1.internal (10.130.0.18): icmp_seq=3 ttl=63 time=0.971 ms
64 bytes from someinternalhost.ru-central1.internal (10.130.0.18): icmp_seq=4 ttl=63 time=0.340 ms
64 bytes from someinternalhost.ru-central1.internal (10.130.0.18): icmp_seq=5 ttl=63 time=0.423 ms
64 bytes from someinternalhost.ru-central1.internal (10.130.0.18): icmp_seq=6 ttl=63 time=5.12 ms
64 bytes from someinternalhost.ru-central1.internal (10.130.0.18): icmp_seq=7 ttl=63 time=1.46 ms
64 bytes from someinternalhost.ru-central1.internal (10.130.0.18): icmp_seq=8 ttl=63 time=1.29 ms

2. на бастионе зайдем по ссш на самфингхост чтобы они обменялись ключами
ssh someinternalhost

The authenticity of host 'someinternalhost (10.130.0.18)' can't be established.
ECDSA key fingerprint is SHA256:1OcqKpQ0HrHd48Baue0svw2RY8VXr+G4/EB/AyOFAm8.
Are you sure you want to continue connecting (yes/no)? yes


3. на хостовой машинке в консоли делаем такой фокус
[informer@informer-dev .ssh]$ ssh -A appuser@84.201.159.213 'ssh -tt someinternalhost'

и все мы попали в самфингхост



bastion_IP = 84.201.159.213
someinternalhost_IP = 10.130.0.18


testapp_IP = 178.154.227.135

testapp_port = 9292

скрипт автоматизированной раскатки машинки с приложенькой

yc compute instance create --name reddit-app --hostname reddit-app --memory=4 \
 --create-boot-disk image-folder-id=standard-images,image-family=ubuntu-1604-lts,size=10GB \
 --network-interface subnet-name=default-ru-central1-a,nat-ip-version=ipv4 \
 --metadata serial-port-enable=1 \
 --metadata-from-file user-data=./metadata.yaml