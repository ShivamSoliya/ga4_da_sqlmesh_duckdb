from sqlmesh import macro
from datetime import datetime, date, timedelta
import pytz

@macro()
def get_date_range_list(evaluator):
    start_date = date(2021, 1, 31)
    end_date = date(2021, 1, 31)
    
    return [[f"/mnt/{date}/*" 
             for date in [(start_date + timedelta(days=i)).strftime('%Y%m%d') 
                for i in range((end_date - start_date).days + 1)]]]

@macro()
def get_output_uri(evaluator):
    return f"/mnt/output/{datetime.now(pytz.timezone('Asia/Kolkata')).strftime('%Y%m%d/%H%M%S')}/latest_session.csv"
                
@macro()
def get_param_value(evaluator, param, target_key: str):
    return f"(SELECT {param}.key.value.int_value WHERE ep.key.key = '{target_key}' limit 1)"

@macro()
def get_user_list(evaluator):
    return "('1026454.4271112504', '1031480.8260955562', '1037360.4939379761')"