data_ids = data_bag("users")
data_ids.each do |data_id|
  usr = data_bag_item("users", data_id)

  user usr["id"] do
    uid      usr["uid"]
    password usr["password"]
    comment  usr["comment"]
    shell    usr["shell"]
    supports :manage_home => true
    action   :create
  end

  if usr["ssh_keys"]
    directory "#{usr["home"]}/.ssh" do
      owner  usr["id"]
      group  usr["id"]
      mode   "0700"
      action :create
    end

    file "#{usr["home"]}/.ssh/authorized_keys" do
      owner   usr["id"]
      group   usr["id"]
      mode    "0600"
      content usr["ssh_keys"].join("\n")
      action  :create
    end
  end
end
