# memory_book

O Memory book é uma proposta de diário digital no qual o usuário pode registrar a descrição, dia, lugar e fotos de um momento ou dia especial. Tudo isso fica é individualizado pois o user precisa realizar um cadastro com e-mail e senha, para tal utilizei o Auth do Firebase garanti também a recuperação de senha e um verificador da força de senha para cadastro (pacote que pode ser visitado na branch ![imagens](lib/passwordtest.dart)).

Os eventos registrado são apresentados na deshboard em uma lista e são armazenado utilizando o FireCloud. Ao clicar em uma memória da lista o user é direcionado para visão da mesma contendo um mapa com marker do local, além da descrição do local e as fotos que foram selecionadas a partir da galeria.

Realizeis testes de widgetes para verificar as mensagens de força de senha, verificar se os botões de login e cadastros execultão quando os campos senha e e-mail são preenchidos.

Na pasta ![imagens](imagens) encontram-se imagens que documentam o funcionamento do sistema.

Tela principal do app:
<br>!<img src="https://github.com/user-attachments/assets/163e3824-eb83-4356-a411-03575c324d84" alt="Memory Book" width="300" />
Tela da memoria:
<br>!<img src="https://github.com/user-attachments/assets/0693b05d-3885-47f5-8c8b-57e6e93f91f1" alt="Memory Book" width="300" />
