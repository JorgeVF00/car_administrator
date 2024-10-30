module MaintenanceServicesHelper
  def service_status_color(status)
    case status
    when 'pending'
      'text-yellow-600 bg-yellow-100 px-2 py-1 rounded-full text-sm'
    when 'in_progress'
      'text-blue-600 bg-blue-100 px-2 py-1 rounded-full text-sm'
    when 'completed'
      'text-green-600 bg-green-100 px-2 py-1 rounded-full text-sm'
    end
  end
end
