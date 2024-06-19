-- codigo para criar e popular tabela base_ouvidoria_mac

CREATE TABLE IF NOT EXISTS base_ouvidoria_mac (
        PROTOCOLO INTEGER,
        DATA_DA_DEMANDA DATE,
        DEMANDA_ATIVA TEXT,
        STATUS TEXT,
        DATA_DE_FECHAMENTO_DEMANDA DATE,
        DIAS_DE_TRAMITACAO INTEGER,
        PRAZO_VENCIDO TEXT,
        CLASSIFICACAO TEXT,
        ASSUNTO TEXT,
        SUBASSUNTO_01 TEXT,
        SUBASSUNTO_02 TEXT,
        SUBASSUNTO_03 TEXT,
        ESTAB_COMERCIAL TEXT,
        PRIMEIRO_DESTINO TEXT,
        DATA_PRIMEIRO_DESTINO_ENCAMINHAMENTO DATE,
        OUVIDORIA_SEGUNDO_ENCAMINHAMENTO TEXT,
        OUVIDORIA_TERCEIRO_ENCAMINHAMENTO TEXT,
        DESTINO_ATUAL TEXT,
        INDICADOR_RMAC TEXT    
    );



    INSERT INTO base_ouvidoria_mac (
        PROTOCOLO,
        DATA_DA_DEMANDA,
        DEMANDA_ATIVA,
        STATUS,
        DATA_DE_FECHAMENTO_DEMANDA,
        DIAS_DE_TRAMITACAO,
        PRAZO_VENCIDO,
        CLASSIFICACAO,
        ASSUNTO,
        SUBASSUNTO_01,
        SUBASSUNTO_02,
        SUBASSUNTO_03,
        ESTAB_COMERCIAL,
        PRIMEIRO_DESTINO,
        DATA_PRIMEIRO_DESTINO_ENCAMINHAMENTO,
        OUVIDORIA_SEGUNDO_ENCAMINHAMENTO,
        OUVIDORIA_TERCEIRO_ENCAMINHAMENTO,
        DESTINO_ATUAL,
        INDICADOR_RMAC)
    SELECT 
        PROTOCOLO,
        DATA_DA_DEMANDA,
        DEMANDA_ATIVA,
        STATUS,
        DATA_DE_FECHAMENTO_DA_DEMANDA,
        DIAS_DE_TRAMITACAO,
        PRAZO_VENCIDO,
        CLASSIFICACAO,
        ASSUNTO,
        SUBASSUNTO_1,
        SUBASSUNTO_2,
        SUBASSUNTO_3,
        ESTAB_COMERCIAL,
        MUN_PRIMEIRO_DESTINO,
        DATA_PRIMEIRO_DESTINO_ENCAMINHAMENTO,
        OUVIDORIA_SEGUNDO_ENCAMINHAMENTO,
        OUVIDORIA_TERCEIRO_ENCAMINHAMENTO,
        DESTINO_ATUAL,
        Indicador_RMAC
    FROM 
        base_ouvidoria;