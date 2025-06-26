# memory_book

O Memory book é uma proposta de diário digital no qual o usuário pode registrar: a descrição da memória, dia ocorrido, lugar (localização via GPS) e fotos de um momento/dia especial. Tudo isso é individualizado, pois o user precisa realizar um cadastro utilizando e-mail e senha, para tal utilizei o Auth do Firebase e garanti também a recuperação de senha e um verificador da força de senha para cadastro (pacote que pode ser visitado na branch [passtest](https://github.com/WilliamM4x/Memory_Book/tree/passtest)).

Os eventos registrado são apresentados na deshboard em uma lista e são armazenado utilizando o FireCloud. Ao clicar em uma memória da lista o user é direcionado para uma visão da mesma contendo um mapa com marker do local no mapa, além da descrição do local, as fotos que foram selecionadas a partir da galeria e a data.

Realizeis testes de widgetes para verificar as mensagens de força de senha, verificar se os botões de login e cadastros execultão quando os campos senha e e-mail são preenchidos.

Na pasta [imagens](imagens) encontram-se imagens que documentam o funcionamento do sistema.

-API's externas:
 * [Geocoding](https://pub.dev/packages/geocoding);

 * [Google_maps_fluter](https://pub.dev/packages/google_maps_flutter_android);

-Recursos do dispositivo: GPS e Galeria.

-Testes unitários no pacote, testes de Widgets na tela de registro e tela de login.

-FireCloud para persistir as memórias e FireAuth para cadastro.

Tela principal do app:

<br>!<img src="https://github.com/user-attachments/assets/163e3824-eb83-4356-a411-03575c324d84" alt="Memory Book" width="300" />

Tela da memória:

<br>!<img src="https://github.com/user-attachments/assets/0693b05d-3885-47f5-8c8b-57e6e93f91f1" alt="Memory Book" width="300" />
