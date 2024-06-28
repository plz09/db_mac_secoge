-- Relacionamento de conectazap com 

DO $$
DECLARE
    column_name text;
    columns_to_keep text[] := array[
        'id_conectazap', 'data', 'whatsapp', 'cns', 'roomid', 'acessou_com', 
        'nome', 'transbordo__horario', 'encerrado_na_susi', 'avaliacao'
    ];
    drop_columns_query text := 'ALTER TABLE atende_gestante.conectazap ';
BEGIN
    FOR column_name IN 
        SELECT col.column_name
        FROM information_schema.columns col
        WHERE col.table_name = 'conectazap' 
        AND col.table_schema = 'atende_gestante'
        AND col.column_name <> ALL(columns_to_keep)
    LOOP
        drop_columns_query := drop_columns_query || 'DROP COLUMN "' || column_name || '", ';
    END LOOP;

    -- Remove the última vírgula e espaço
    drop_columns_query := left(drop_columns_query, length(drop_columns_query) - 2) || ';';

    -- Execute a query dinâmica
    EXECUTE drop_columns_query;
END $$;


/*

COLUNA data: definir formato p/ data
COLUNA whatsapp: definir formato p/ número inteiro
COLUNA CNS: definir formato p/ número inteiro
Há mais COLUNAS a ser removidas no banco de dados do que mantidas.
MANTER COLUNAS: id_atende_gestante_conectazap, data, roomid, acessou_com:, nome, 
whatsapp, transbordo_|_horario, encerrado_na_susi, avaliacao. As demais podem ser 
removidas do banco de dados (mantidas só no Sharepoint)

*/