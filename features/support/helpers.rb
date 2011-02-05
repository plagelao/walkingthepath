MONTHS = ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre']
def month_name(month_number)
  MONTHS[@event_date.month - 1]
end
def next_week
  DateTime.now + 7
end

def previous_week
  DateTime.now - 7
end
