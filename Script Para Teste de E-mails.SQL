BEGIN 

    ALPGA002.ALPPA002001( 

        1,                              --GRUPO 

        1,                              --EMPRESA 

        0,                              --FILIAL 

        'lucas.carnizella@inova.ind.br',--PARA 

        'notificacao@inova.ind.br',     --DE 

        'TESTE ENVIO DE ALERTA',        --TITULO 

        'This is a multi-part message in MIME format. Este email está no formato html.', --CORPO 

        NULL, 

        '192.168.254.201',              --HOST SMTP 

        '525',                          --PORTA SMTP 

        NULL,                           --DOMINIO 

        'EFFECTIVE_ALERT_MESSAGE', 

        'N',                            --RECEBE EM COPIA 

        NULL,                           --RECEBE EM COPIA OCULTA 

        'notificacao@inova.ind.br',     --USUARIO AUTENTICACAO 

        'fgytsskjnfzydgvp',             --SENHA AUTENTICACAO 

        8,                              --ALERTA 

        NULL, 

        NULL, 

    NULL); 

END; 