from sqlmesh import macro
import datetime

@macro()
def get_date_range_list(evaluator):
    start_date = datetime.date(2021, 1, 31)
    end_date = datetime.date(2021, 1, 31)
    
    return [[f"~/dev/mnt/{date}/*" 
             for date in [(start_date + datetime.timedelta(days=i)).strftime('%Y%m%d') 
                for i in range((end_date - start_date).days + 1)]]]

@macro()
def get_param_value(evaluator, param, target_key: str):
    return f"(SELECT {param}.key.value.int_value WHERE ep.key.key = '{target_key}' limit 1)"

@macro()
def get_user_list(evaluator):
    return "('1026454.4271112504', '1031480.8260955562', '1037360.4939379761')"