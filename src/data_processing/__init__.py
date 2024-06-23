from .ds_unidades import read_ds_unidades_data
from .producao import read_producao_data
from .ouvidoria import read_ouvidoria_data
from .horus import read_horus_data
from .mae_coruja import process_mae_coruja_data
from .atende_gestante import read_atende_gestante_data
from .atbasica import read_atbasica_data
from .spa import process_spa_files

def get_data_processing_functions():
    return {
        'ds_unidades': read_ds_unidades_data,
       # 'producao': read_producao_data,
       # 'ouvidoria': read_ouvidoria_data,
       # 'horus': read_horus_data,
       # 'mae_coruja': process_mae_coruja_data,
       # 'atende_gestante': read_atende_gestante_data,
       # 'atbasica': read_atbasica_data,
       # 'spa': process_spa_files
    }
