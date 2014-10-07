ActiveAdmin.register_page "Most_Least" do

  menu priority: 1, label: "Most/Least"

  content title: "Most/Least Interviewers" do

    num_days  = params[:days].present?  ? params[:days].to_i  : 30
    num_limit = params[:limit].present? ? params[:limit].to_i : 10

    query = Employee.
      joins { [
        grade,
        Interview.
          where { interview_date >= num_days.days.ago }.
          as('employee_interviews').
          on { id == employee_interviews.employee_id }.
          outer
      ] }.
      group{ employees.id }.
      select{ [
        employees.name,
        grade.name.as(grade_name),
        count(employee_interviews.id).as(interview_count)
      ] }.
      limit(num_limit)

    columns do
      column do
        h3 "Most Interviewers by Role (#{num_days} days)"

        most_query = query.order('interview_count DESC')
        Role.all.each do |role|
          panel role.name do
            records = most_query.where(role_id: role.id)
            table_for records do
              column :name
              column :grade_name
              column :interview_count
            end
          end
        end
      end

      column do
        h3 "Least Interviewers by Role (#{num_days} days)"

        least_query = query.order('interview_count ASC')
        Role.all.each do |role|
          panel role.name do
            records = least_query.where(role_id: role.id)
            table_for records do
              column :name
              column :grade_name
              column :interview_count
            end
          end
        end
      end
    end

  end
end