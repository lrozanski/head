require 'English'
require 'modules/common/inputs'
require 'win32ole'
require 'modules/common/TestClass'
require 'modules/logger/example_logger1'
require 'mysql'
require 'test/unit/assertions'
#require 'modules/propertis'
#require 'modules/Centers/CenterCreateEdit'

include Watir
class ClientCreateEdit<TestClass
  #connecting to database and getting the searchID for office
  
  def database_connection()
    db_connect()
    dbquery("select o.search_id,o.office_id from office o,personnel p where o.office_id=p.office_id and p.login_name='"+$validname+"'")
    @@search_id=dbresult[0]
    dbquery("SELECT lookup_value FROM lookup_value_locale where lookup_id=82 and locale_id=1")
    @@lookup_name_client=dbresult[0]
    dbquery("SELECT lookup_value FROM lookup_value_locale where lookup_id=83 and locale_id=1")
    @@lookup_name_group=dbresult[0]
    dbquery("select office_id,display_name from office where status_id=1 and office_level_id=5 and search_id like '"+@@search_id+"%'")
    @@office_id=dbresult[0]
       if ($validname=="mifos") then
        dbquery("select personnel_id,display_name from personnel where level_id=1 and office_id="+@@office_id)
        @@personnel_id=dbresult[0]
        @@loan_officer=dbresult[1]
      else
        dbquery("select personnel_id,display_name from personnel where level_id=1 and login_name='"+$validname+"'")
        @@personnel_id=dbresult[0]
        @@loan_officer=dbresult[1]
      end
  end
  def read_client_values(rowid,sheetid)
    if sheetid==1 then
      @salutation=arrval[rowid+=1]
      @fname=arrval[rowid+=1]
      #added so that the excel sheet need not be updated for every run
      @fname1=@fname+Time.now.strftime("%d%m%Y%H%M%S")
      @lname=arrval[rowid+=1]
      @date=arrval[rowid+=1].to_i.to_s
      @month=arrval[rowid+=1].to_i.to_s
      @year=arrval[rowid+=1].to_i.to_s
      @gender=arrval[rowid+=1]
      @povertystatus=arrval[rowid+=1]
      @religion=arrval[rowid+=1]
      @sorftype=arrval[rowid+=1]
      @sorffname=arrval[rowid+=1]
      @sorflname=arrval[rowid+=1]
      @custom=arrval[rowid+=1].to_i.to_s #no more a custom field
      @statusname=arrval[rowid+=1]
    elsif sheetid==2 then
      @salutation=arrval[rowid+=1]
      @fname=arrval[rowid+=1]
      @fname1=@fname+Time.now.strftime("%d%m%Y%H%M%S")
      @mname=arrval[rowid+=1]
      @sname=arrval[rowid+=1]
      @lname=arrval[rowid+=1]
      @govtid=arrval[rowid+=1]
      @date=arrval[rowid+=1].to_i.to_s
      @month=arrval[rowid+=1].to_i.to_s
      @year=arrval[rowid+=1].to_i.to_s
      @gender=arrval[rowid+=1]
      @povertystatus=arrval[rowid+=1]
      @mstatus=arrval[rowid+=1]
      @noofchildren=arrval[rowid+=1].to_i.to_s
      @religion=arrval[rowid+=1]
      @education=arrval[rowid+=1]
      @sorftype=arrval[rowid+=1]
      @sorffname=arrval[rowid+=1]
      @sorfmname=arrval[rowid+=1]
      @sorfsname=arrval[rowid+=1]
      @sorflname=arrval[rowid+=1]
      @address1=arrval[rowid+=1]
      @address2=arrval[rowid+=1]
      @address3=arrval[rowid+=1]
      @city=arrval[rowid+=1]
      @state=arrval[rowid+=1]
      @country=arrval[rowid+=1]
      @pcode=arrval[rowid+=1].to_i.to_s
      @phone=arrval[rowid+=1].to_i.to_s
      @custom=arrval[rowid+=1].to_i.to_s
      @statusname=arrval[rowid+=1]
      @externalid=arrval[rowid+=1]
      @tdate=arrval[rowid+=1].to_i.to_s
      @tmonth=arrval[rowid+=1].to_i.to_s        
      @tyear=arrval[rowid+=1].to_i.to_s
      @notes=arrval[rowid+=1]
    elsif sheetid==3 then
      @salutation=arrval[rowid+=1]
      @fname=arrval[rowid+=1]
      @fname1=@fname+Time.now.strftime("%d%m%Y%H%M%S")
      @mname=arrval[rowid+=1]
      @sname=arrval[rowid+=1]
      @lname=arrval[rowid+=1]
      @govtid=arrval[rowid+=1]
      @date=arrval[rowid+=1].to_i.to_s
      @month=arrval[rowid+=1].to_i.to_s
      @year=arrval[rowid+=1].to_i.to_s
      @gender=arrval[rowid+=1]
      @povertystatus=arrval[rowid+=1]
      @mstatus=arrval[rowid+=1]
      @noofchildren=arrval[rowid+=1].to_i.to_s
      @religion=arrval[rowid+=1]
      @education=arrval[rowid+=1]
      @sorftype=arrval[rowid+=1]
      @sorffname=arrval[rowid+=1]
      @sorfmname=arrval[rowid+=1]
      @sorfsname=arrval[rowid+=1]
      @sorflname=arrval[rowid+=1]
      @address1=arrval[rowid+=1]
      @address2=arrval[rowid+=1]
      @address3=arrval[rowid+=1]
      @city=arrval[rowid+=1]
      @state=arrval[rowid+=1]
      @country=arrval[rowid+=1]
      @pcode=arrval[rowid+=1].to_i.to_s
      @phone=arrval[rowid+=1].to_i.to_s
      @custom=arrval[rowid+=1].to_i.to_s
      @statusname=arrval[rowid+=1]
      @externalid=arrval[rowid+=1]
      @tdate=arrval[rowid+=1].to_i.to_s
      @tmonth=arrval[rowid+=1].to_i.to_s        
      @tyear=arrval[rowid+=1].to_i.to_s
      @frequncymeeting=arrval[rowid+=1].to_i.to_s
      @monthtype=arrval[rowid+=1].to_i.to_s
      @reccurweek=arrval[rowid+=1].to_i.to_s
      @weekweekday=arrval[rowid+=1].to_i.to_s
      @monthday=arrval[rowid+=1].to_i.to_s
      @monthmonth=arrval[rowid+=1].to_i.to_s
      @monthrank=arrval[rowid+=1].to_i.to_s
      @monthweek=arrval[rowid+=1].to_i.to_s
      @monthmonthrank=arrval[rowid+=1].to_i.to_s
      @meetingplace=arrval[rowid+=1]
    end
    if @salutation=="mr" then
      @salutation="47"
    elsif @salutation=="mrs" then
      @salutation="48"
    elsif @salutation=="ms" then
      @salutation="228"
    end
    if @gender=="male"
      @gender="49"
    elsif @gender=="female" then
      @gender="50"
    end
    
    if @povertystatus=="Very poor"
      @povertystatus="41"
    elsif @povertystatus=="Poor" then
      @povertystatus="42"
   elsif @povertystatus=="Non-poor" then
      @povertystatus="43"
    end
    
    if @religion=="hindu" then
      @religion="130"
    elsif @religion=="muslim" then
      @religion="131"
    elsif @religion=="christian" then
      @religion="221"
    end
    if @sorftype=="spouse" then
      @sorftype="1"
    elsif @sorftype=="father" then
      @sorftype="2"
    end
    if @mstatus=="married" then
      @mstatus="66"
    elsif @mstatus=="unmarried" then
      @mstatus="67"
    elsif @mstatus=="widowed" then
      @mstatus="220"
    end
    if @education=="onlymember" then
      @education="134"
    elsif @education=="onlyhusband" then
      @education="135"
    elsif @education=="bothliterate" then
      @education="226"
    elsif @education=="bothilliterate" then
      @education="227"
    end
    if @statusname=="partial" then
      @statusname="Save For Later"
    elsif @statusname=="pending"
      @statusname="Submit For Approval"
    end
  end
  def Salutation()
    @salutation
  end
  def Fname()
    @fname1
  end
  def Mname()
    @mname 
  end
  def Sname
    @sname
  end
  def Lname
    @lname
  end
  def Govtid
    @govtid
  end
  def Date
    @date
  end
  def Month
    @month
  end
  def Year
    @year
  end
  def Gender
    @gender
  end
  def PovertyStatus
    @povertystatus
  end
  def Mstatus
    @mstatus
  end
  def  Noofchildren
    @noofchildren
  end
  def Religion 
    @religion
  end
  def Education 
    @education
  end
  def Sorftype
    @sorftype
  end
  def Sorffname 
    @sorffname
  end
  def Sorfmname 
    @sorfmname
  end
  def Sorfsname  
    @sorfsname
  end
  def Sorflname
    @sorflname 
  end
  def Address1
    @address1
  end
  def Address2
    @address2
  end
  def Address3
    @address3
  end
  def City
    @city
  end
  def State
    @state
  end
  def Country
    @country 
  end
  def Pcode
    @pcode
  end
  def Phone
    @phone
  end
  def Custom
    @custom
  end
  def Statusname
    @statusname
  end
  def Externalid
    @externalid
  end
  def Tdate
    @tdate
  end
  def Tmonth
    @tmonth
  end
  def Tyear
    @tyear
  end
  def Frequncymeeting
    @frequncymeeting
  end
  def Monthtype
    @monthtype
  end
  def Reccurweek
    @reccurweek
  end
  def Weekweekday
    @weekweekday
  end
  def Monthday
    @monthday
  end
  def Monthmonth 
    @monthmonth 
  end
  def Monthrank
    @monthrank
  end
  def Monthweek
    @monthweek
  end
  def Monthmonthrank
    @monthmonthrank
  end
  def Meetingplace
    @meetingplace
  end
  def Notes
    @notes
  end
  #logining into Mifos
  
  def client_login()
    begin  
      start
      login($validname,$validpwd)
    rescue =>excp
      quit_on_error(excp) 
    end
  end
  #calling the method load_properties from test class to read properties from properties file
  def propertis_load()
    
    @@clientprop=load_properties("modules/propertis/ClientUIResources.properties")
    @@meetingprop=load_properties("modules/propertis/Meeting.properties")
    @@adminprop=load_properties("modules/propertis/adminUIResources.properties")
    @@menuprop=load_properties("modules/propertis/MenuResources.properties")
    @@groupprop=load_properties("modules/propertis/GroupUIResources.properties")
    @@officeprop=load_properties("modules/propertis/OfficeUIResources.properties")
    @@customerprop=load_properties("modules/propertis/CustomerUIResources.properties")
    
  end
  
  #labels like member are fetched from the database
  def get_labels_from_db
    begin
      dbquery("select Lookup_value from lookup_value_locale where lookup_id=108")
      @@branch_label=dbresult[0]
      dbquery("select Lookup_value from lookup_value_locale where lookup_id=82")
      @@member_label=dbresult[0]
      dbquery("SELECT lookup_value FROM lookup_value_locale where lookup_id=82 and locale_id=1")
       @@lookup_name_client=dbresult[0]
      dbquery("SELECT lookup_value FROM lookup_value_locale where lookup_id=83 and locale_id=1")
      @@lookup_name_group=dbresult[0]
      dbquery("SELECT lookup_value FROM lookup_value_locale where lookup_id=84 and locale_id=1")
      @@lookup_name_center=dbresult[0]
      
      rescue =>excp
      quit_on_error(excp) 
      
    end
  end
  
  def read_values_from_hash()
    @@client_salitution_msg=string_replace_message(@@customerprop['errors.mandatory'],"{0}",@@clientprop['client.SalutationValue'])
    @@client_fname_msg=string_replace_message(@@customerprop['errors.mandatory'],"{0}",@@clientprop['client.FirstNameValue'])
    @@client_lname_msg=string_replace_message(@@customerprop['errors.mandatory'],"{0}",@@clientprop['client.LastNameValue'])
    @@client_dob_msg=string_replace_message(@@customerprop['errors.mandatory'],"{0}",@@clientprop['client.DateOfBirthValue'])
    @@client_gender_msg=string_replace_message(@@customerprop['errors.mandatory'],"{0}",@@clientprop['client.GenderValue'])
    @@client_education_msg=string_replace(@@clientprop['exception.framework.fieldConfiguration.mandatory'],"{0}",@@clientprop['client.EducationLevelValue'])
    @@client_relesion=string_replace(@@clientprop['exception.framework.fieldConfiguration.mandatory'],"{0}",@@clientprop['client.CitizenshipValue'])
    @@client_spo_or_father_type_msg=string_replace(@@clientprop['errors.requiredSelect'],"{0}",@@clientprop['client.SpouseNameTypeValue'])
    @@client_spo_or_father_fname_msg=string_replace_message(@@customerprop['errors.mandatory'],"{0}",@@clientprop['client.SpouseFirstNameValue'])
    @@client_spo_or_father_lname_msg=string_replace_message(@@customerprop['errors.mandatory'],"{0}",@@clientprop['client.SpouseLastNameValue'])
    #@@client_note_msg=string_replace(@@clientprop['errors.mandatory'],"{0}",@@clientprop['client.Note'])      
    @@client_note_msg=@@customerprop['errors.mandatorytextarea']
    @@client_custom_msg=remove_li_tag(@@clientprop['errors.requiredCustomField'])
    @@client_formedby_msg=remove_li_tag(@@clientprop['FormedByLoanOfficerBlankException'])
    @@button_continue=@@clientprop['button.continue']
    @@button_preview=@@clientprop['button.preview']
    @@button_submit=@@clientprop['button.submit']
    @@return_to_details_page=@@clientprop['client.butbachdetpage']
    @@edit_group_client=string_replace_message(@@clientprop['client.EditGroupMembershipLink'],"group",@@lookup_name_group)
    @@edit_branch_membership_link=@@clientprop['client.EditLink']+" "+@@branch_label.to_s+" "+@@clientprop['client.MembershipLink']
    @@member_outof_group_link=@@groupprop['Group.clickheretocontinueif']+" "+@@groupprop['Group.group']+" "+@@groupprop['Group.membershipisnotrequiredforyour']+" "+@@member_label
    @@Member_select_branch_msg=@@clientprop['client.CreateTitle']+" "+@@member_label+" - "+@@clientprop['client.SelectBranchHeading']+" "+@@branch_label
    @@change_group_membership=@@groupprop['Group.change']+" "+@@groupprop['Group.group']+" "+@@groupprop['Group.membership']
    @@view_all_account_activity=@@clientprop['client.viewallactivities']
    @@member_applycharges1=@@clientprop['client.ApplyCharges']
    @@member_applycharges2=@@clientprop['clinet.applycharges']
    @@view_details=@@clientprop['client.viewdetails']
    @@member_applypayment=@@clientprop['client.apply_payment']
    @@active_members_forGroup=@@clientprop['client.NoOfActive']+" "+@@lookup_name_client+"s"
    @@createclient=@@clientprop['client.CreateTitle']+" "+@@lookup_name_client
    @@client_mfi_page_msg=(@@createclient+" "+@@clientprop['client.CreateMfiInformationTitle']).squeeze(" ")
    @@client_review=@@createclient+" "+@@clientprop['client.CreatePreviewReviewSubmitTitle'].squeeze(" ")    
  end
  
  #checking for the link Create new client in clients&accounts section
  
  def check_createnewclient_link()
    begin
      $ie.link(:text,"Clients & Accounts").click
      @@createclientlabel=@@menuprop['label.createnew']+' '+@@lookup_name_client
      assert($ie.contains_text(@@createclientlabel))
      $logger.log_results("Link Check in Clients &amp; Accounts Section",@@createclientlabel,@@createclientlabel,"passed")
    rescue Test::Unit::AssertionFailedError=>e
      $logger.log_results("Link Check in Clients &amp; Accounts Section",@@createclientlabel,"NA","failed")
    rescue =>excp
      quit_on_error(excp) 
    end
  end
  
  
  #checking the Create new client link functionality
  
  def select_grouppage_check()
    begin
      $ie.link(:text,@@createclientlabel).click
      @@createclient=@@clientprop['client.CreateTitle']+" "+@@lookup_name_client
      @@selectgrouptext=(@@createclientlabel+" - "+@@clientprop['client.select']+" "+@@lookup_name_group).squeeze(" ")
      assert($ie.contains_text(@@selectgrouptext))
      $logger.log_results(@@createclientlabel,"Link Should work","Working","passed")
    rescue Test::Unit::AssertionFailedError=>e
      $logger.log_results(@@createclientlabel,"Link work","Not Working","failed")
    rescue =>excp
      quit_on_error(excp) 
    end
  end
  
  
  #checking cancel button functionality in select group page
    
  def click_cancel_from_group_select()
    begin
      @@button_cancel=@@clientprop['button.cancel']
      $ie.button(:value,@@button_cancel).click
      assert($ie.contains_text(@@createclientlabel))
      $logger.log_results("Cancel button in select group page","Should work","Working","Passed")
    rescue Test::Unit::AssertionFailedError=>e
      $logger.log_results("Cancel button in select group page","Should work","Not Working","Passed")
    rescue =>excp
      quit_on_error(excp) 
    end
  end
  
  #Searching for a group which is not in database
  def no_groups_while_search()
    begin
      $ie.link(:text,"Clients & Accounts").click
      $ie.link(:text,@@createclientlabel).click
      $ie.text_field(:name,"searchString").set("%^")        
      $ie.button(:value,@@groupprop['button.proceed']).click
      assert($ie.contains_text("No results found"))
      $logger.log_results("Displaying No results when there is no Group Names in database","N/A","N/A","Passed")
    rescue Test::Unit::AssertionFailedError=>e
      $logger.log_results("Displaying results when there is no Group Names in database","N/A","N/A","Failed")
    rescue =>excp
      quit_on_error(excp) 
    end
  end
  
  #Checking the next link functionality in search group page
  
  def check_next_link_in_search_group_page()
    begin
      $ie.link(:text,"Clients & Accounts").click
      $ie.link(:text,@@createclientlabel).click
      $ie.text_field(:name,"searchString").set("%")        
      $ie.button(:value,@@groupprop['button.proceed']).click
      dbquery("select count(*) from customer where customer_level_id=2")
      @@count=dbresult[0]
      if @@count.to_i>10
        $ie.link(:text,"Next").click
        begin
          assert($ie.contains_text("Results 11"))
          $logger.log_results("Next Button","Should Work","Working","Passed")
        rescue Test::Unit::AssertionFailedError=>e
          $logger.log_results("Next Button","Should Work","Working","Failed")
        end
      end
    rescue =>excp
      quit_on_error(excp) 
    end
  end
  
  #checks the previous link when number of records are more than 10.skips otherwise
  def check_previous_link_in_search_group_page()
    begin
      if @@count.to_i>10
        $ie.link(:text,"Previous").click
        begin
          assert($ie.contains_text("Results 1"))
          $logger.log_results("Previous Button","Should Work","Working","Passed")
        rescue Test::Unit::AssertionFailedError=>e
          $logger.log_results("Previous Button","Should Work","Working","Failed")
        end
      end
    rescue =>excp
      quit_on_error(excp) 
    end
  end
  
  #selects the group before creating a client
  def select_group()
    begin
      $ie.link(:text,"Clients & Accounts").click
      $ie.link(:text,@@createclientlabel).click
      dbquery("select office_id,display_name from office where status_id=1 and office_level_id=5 and search_id like '"+@@search_id+"%'")
      @@office_id=dbresult[0]
      @@display_name=dbresult[1]
      if (@@office_id=="1") then
        get_next_data
        @@office_id=dbresult[0]
        @@display_name=dbresult[1]
      end      
      dbquery("select customer_id,display_name,global_cust_num from customer where customer_level_id=2 and status_id=9 and branch_id=" + @@office_id)
      @@gdisplay_name=dbresult[1] 
      @@customer_id=dbresult[0] 
      $ie.text_field(:name,"searchString").set(@@gdisplay_name)        
      $ie.button(:value,@@groupprop['button.proceed']).click
      $ie.link(:text,@@gdisplay_name).click
      $ie.wait(10)
      @@client_select_client=(@@createclient+" "+@@clientprop['client.CreatePersonalInformationTitle']).squeeze(" ")
      assert($ie.contains_text(@@client_select_client))
      $logger.log_results(@@client_select_client,"Page Should appear","appearing","passed")
    rescue Test::Unit::AssertionFailedError=>e
      $logger.log_results(@@client_select_client,"Page Should appear","not appearing","failed")
    rescue =>excp
      quit_on_error(excp) 
    end      
  end
  
  
  #checking all the mandatory fields in enter personal information page
  
  def check_all_mandatory_fields_for_client()
    begin
      $ie.button(:value,@@button_continue).click
      $ie.wait
      assert($ie.contains_text(@@client_salitution_msg))and \
      assert($ie.contains_text(@@client_fname_msg))and \
      assert($ie.contains_text(@@client_lname_msg))and \
      assert($ie.contains_text(@@client_dob_msg))and \
      assert($ie.contains_text(@@client_gender_msg))and \
      assert($ie.contains_text(@@client_spo_or_father_type_msg))and \
      assert($ie.contains_text(@@client_spo_or_father_fname_msg))and \
      assert($ie.contains_text(@@client_spo_or_father_lname_msg))and \
      assert($ie.contains_text(@@client_custom_msg))
      $logger.log_results("Checking of all mandatory check in Enter personnel information","NA","NA","passed")
    rescue Test::Unit::AssertionFailedError=>e
      $logger.log_results("Checking of all mandatory fields in Enter personnel information","NA","NA","failed")
    rescue =>excp
      quit_on_error(excp) 
    end
  end
  
  def check_all_mandatory_when_salutation_selected()
    begin
      $ie.select_list(:name,"clientName.salutation").select_value("47")
      $ie.button(:value,@@button_continue).click
      $ie.wait
      assert($ie.contains_text(@@client_fname_msg))and \
      assert($ie.contains_text(@@client_lname_msg))and \
      assert($ie.contains_text(@@client_dob_msg))and \
      assert($ie.contains_text(@@client_gender_msg))and \
      assert($ie.contains_text(@@client_spo_or_father_type_msg))and \
      assert($ie.contains_text(@@client_spo_or_father_fname_msg))and \
      assert($ie.contains_text(@@client_spo_or_father_lname_msg))and \
      assert($ie.contains_text(@@client_custom_msg))
      $logger.log_results("All mandatory check in Enter personnel information with out salutation ","NA","NA","passed")
    rescue Test::Unit::AssertionFailedError=>e
      $logger.log_results("all mandatory check with out salutation","NA","NA","failed")
    rescue =>excp
      quit_on_error(excp) 
    end
  end
  
  #checking mandatory with out salutation and firstname in enter personal information page
  
  def check_all_mandatory_when_salutation_fname_entered()
    begin
      $ie.select_list(:name,"clientName.salutation").select_value("47")
      $ie.text_field(:name,"clientName.firstName").set("aaa")
      $ie.button(:value,@@button_continue).click
      assert($ie.contains_text(@@client_lname_msg))and \
      assert($ie.contains_text(@@client_dob_msg))and \
      assert($ie.contains_text(@@client_gender_msg))and \
      assert($ie.contains_text(@@client_spo_or_father_type_msg))and \
      assert($ie.contains_text(@@client_spo_or_father_fname_msg))and \
      assert($ie.contains_text(@@client_spo_or_father_lname_msg))and \
      assert($ie.contains_text(@@client_custom_msg))
      $logger.log_results("All mandatory check in Enter personnel information with out salutation and firstname","NA","NA","passed")
    rescue Test::Unit::AssertionFailedError=>e
      $logger.log_results("All mandatory check in Enter personnel information with out salutation and firstname","NA","NA","failed")
    end
  end
  
  #checking mandatory with out salutation,firstname and last name in enter personal information page
  
  def check_all_mandatory_when_salutation_fname_lname_entered()
    begin
      $ie.select_list(:name,"clientName.salutation").select_value("47")
      $ie.text_field(:name,"clientName.firstName").set("aaa")
      $ie.text_field(:name,"clientName.lastName").set("aaa")
      $ie.button(:value,@@button_continue).click
      assert($ie.contains_text(@@client_dob_msg))and \
      assert($ie.contains_text(@@client_gender_msg))and \
      assert($ie.contains_text(@@client_spo_or_father_type_msg))and \
      assert($ie.contains_text(@@client_spo_or_father_fname_msg))and \
      assert($ie.contains_text(@@client_spo_or_father_lname_msg))and \
      assert($ie.contains_text(@@client_custom_msg))
      $logger.log_results("All mandatory check in Enter personnel information with out salutation, firstname and lastname ","NA","NA","passed")
    rescue Test::Unit::AssertionFailedError=>e 
      $logger.log_results("All mandatory check in Enter personnel information with out salutation, firstname and lastname","NA","NA","failed")
    rescue =>excp
      quit_on_error(excp) 
    end
  end
  
  
  #checking mandatory with out salutation,firstname,dob and last name in enter personal information page
  
  def check_all_mandatory_when_salutation_fname_lname_dob_entered()
    begin
      $ie.select_list(:name,"clientName.salutation").select_value("47")
      $ie.text_field(:name,"clientName.firstName").set("aaa")
      $ie.text_field(:name,"clientName.lastName").set("aaa")
      $ie.text_field(:name,"dateOfBirthDD").set("09")
      $ie.text_field(:name,"dateOfBirthMM").set("10")
      $ie.text_field(:name,"dateOfBirthYY").set("1981")
      $ie.button(:value,@@button_continue).click
      assert($ie.contains_text(@@client_gender_msg))and \
      assert($ie.contains_text(@@client_spo_or_father_type_msg))and \
      assert($ie.contains_text(@@client_spo_or_father_fname_msg))and \
      assert($ie.contains_text(@@client_spo_or_father_lname_msg))and \
      assert($ie.contains_text(@@client_custom_msg))
      $logger.log_results("all mandatory check with out salutation, firstname, lastname and DOB ","NA","NA","passed")
    rescue Test::Unit::AssertionFailedError=>e
      $logger.log_results("all mandatory check with out salutation, firstname, lastname and DOB","NA","NA","failed")
    rescue =>excp
      quit_on_error(excp) 
    end
  end
  
  
  #checking mandatory with out salutation,firstname,dob,gender and last name in enter personal information page
  
  def check_all_mandatory_when_salutation_fname_lname_dob_gender_entered()
    begin
      $ie.select_list(:name,"clientName.salutation").select_value("47")
      $ie.text_field(:name,"clientName.firstName").set("aaa")
      $ie.text_field(:name,"clientName.lastName").set("aaa")
      $ie.text_field(:name,"dateOfBirthDD").set("09")
      $ie.text_field(:name,"dateOfBirthMM").set("10")
      $ie.text_field(:name,"dateOfBirthYY").set("1981")
      $ie.select_list(:name,"clientDetailView.gender").select_value("49")
      $ie.button(:value,@@button_continue).click
      assert($ie.contains_text(@@client_spo_or_father_type_msg))and \
      assert($ie.contains_text(@@client_spo_or_father_fname_msg))and \
      assert($ie.contains_text(@@client_spo_or_father_lname_msg))and \
      assert($ie.contains_text(@@client_custom_msg))
      $logger.log_results("all mandatory check with out salutation, firstname, lastname, DOB and Gender ","NA","NA","passed")
    rescue Test::Unit::AssertionFailedError=>e
      $logger.log_results("all mandatory check with out salutation, firstname, lastname, DOB and Gender","NA","NA","failed")
    rescue =>excp
      quit_on_error(excp) 
    end
  end
  
  
  #checking mandatory with out salutation,firstname,dob,gender,religion,educationlevel,spouce or father type and last name in enter personal information page
  
  def check_all_mandatory_when_salutation_fname_lname_dob_gender_SpouseFatherType_entered()
    begin
      $ie.select_list(:name,"clientName.salutation").select_value("47")
      $ie.text_field(:name,"clientName.firstName").set("aaa")
      $ie.text_field(:name,"clientName.lastName").set("aaa")
      $ie.text_field(:name,"dateOfBirthDD").set("09")
      $ie.text_field(:name,"dateOfBirthMM").set("10")
      $ie.text_field(:name,"dateOfBirthYY").set("1981")
      $ie.select_list(:name,"clientDetailView.gender").select_value("49")
      $ie.select_list(:name,"spouseName.nameType").select_value("1")
      $ie.button(:value,@@button_continue).click
      assert($ie.contains_text(@@client_spo_or_father_fname_msg))and \
      assert($ie.contains_text(@@client_spo_or_father_lname_msg))and \
      assert($ie.contains_text(@@client_custom_msg))
      $logger.log_results("all mandatory check with out salutation, firstname, lastname, religion,Education level, DOB, spouce or father type and Gender ","NA","NA","passed")
    rescue Test::Unit::AssertionFailedError=>e
      $logger.log_results("all mandatory check with out salutation, firstname, lastname, religion,Education level, DOB, spouce or father type and Gender","NA","NA","failed")
    rescue =>excp
      quit_on_error(excp) 
    end
  end
  
  
  #checking mandatory with out salutation,firstname,dob,gender,religion,educationlevel,spouce or father type and last name in enter personal information page
  
  def check_mandatory_when_SpouseorFatherLastName_AdditionalInformation_not_entered()
    begin
      $ie.select_list(:name,"clientName.salutation").select_value("47")
      $ie.text_field(:name,"clientName.firstName").set("aaa")
      $ie.text_field(:name,"clientName.lastName").set("aaa")
      $ie.text_field(:name,"dateOfBirthDD").set("09")
      $ie.text_field(:name,"dateOfBirthMM").set("10")
      $ie.text_field(:name,"dateOfBirthYY").set("1981")
      $ie.select_list(:name,"clientDetailView.gender").select_value("49")
      $ie.select_list(:name,"spouseName.nameType").select_value("1")
      $ie.text_field(:name,"spouseName.firstName").set("AAA")
      $ie.button(:value,@@button_continue).click
      assert($ie.contains_text(@@client_spo_or_father_lname_msg))and \
      assert($ie.contains_text(@@client_custom_msg))
      $logger.log_results("all mandatory check with out salutation, firstname, lastname, religion,Education level, DOB, spouce or father type, spouce or father first name and Gender ","NA","NA","passed")
    rescue Test::Unit::AssertionFailedError=>e
      $logger.log_results("all mandatory check with out salutation, firstname, lastname, religion,Education level, DOB, spouce or father type, spouce or father first name and Gender","NA","NA","failed")
    rescue =>excp
      quit_on_error(excp) 
    end
  end
  
  
  #checking mandatory with out salutation,firstname,dob,gender,religion,educationlevel,spouce or father type and last name and spouce or father type and last name in enter personal information page
  
  def check_mandatory_when_AdditionalInformation_not_entered()
    begin
      $ie.select_list(:name,"clientName.salutation").select_value("47")
      $ie.text_field(:name,"clientName.firstName").set("aaa")
      $ie.text_field(:name,"clientName.lastName").set("aaa")
      $ie.text_field(:name,"dateOfBirthDD").set("09")
      $ie.text_field(:name,"dateOfBirthMM").set("10")
      $ie.text_field(:name,"dateOfBirthYY").set("1981")
      $ie.select_list(:name,"clientDetailView.gender").select_value("49")
      $ie.select_list(:name,"spouseName.nameType").select_value("1")
      $ie.text_field(:name,"spouseName.firstName").set("AAA")
      $ie.text_field(:name,"spouseName.lastName").set("AAA")
      $ie.button(:value,@@button_continue).click
      assert($ie.contains_text(@@client_custom_msg))
      $logger.log_results("all mandatory check with out salutation, firstname, lastname, religion,Education level, DOB, spouce or father type, spouce or father first name,spouce or father last name and Gender ","NA","NA","passed")
    rescue Test::Unit::AssertionFailedError=>e
      $logger.log_results("all mandatory check with out salutation, firstname, lastname, religion,Education level, DOB, spouce or father type, spouce or father first name,spouce or father lats name and Gender","NA","NA","failed")
    rescue =>excp
      quit_on_error(excp) 
    end
  end
  
  #Method for Create client with all mandatory data in enter personal information page
  
  def create_client_with_all_mandatory_data(nsalutation,nfname,nlname,ndate,nmonth,nyear,ngender,npovertystatus,nreligion,nsorftype,nsorffname,nsorflname,ncustom)
    begin
      select_group()
      @@client_mfi_page_msg=(@@createclient+" "+@@clientprop['client.CreateMfiInformationTitle']).squeeze(" ")
      $ie.select_list(:name,"clientName.salutation").select_value(nsalutation)
      $ie.text_field(:name,"clientName.firstName").set(nfname)
      $ie.text_field(:name,"clientName.lastName").set(nlname)
      $ie.text_field(:name,"dateOfBirthDD").set(ndate)
      $ie.text_field(:name,"dateOfBirthMM").set(nmonth)
      $ie.text_field(:name,"dateOfBirthYY").set(nyear)
      $ie.select_list(:name,"clientDetailView.gender").select_value(ngender)
      $ie.select_list(:name,"clientDetailView.povertyStatus").select_value(npovertystatus)
      $ie.select_list(:name,"clientDetailView.citizenship").select_value(nreligion)
      $ie.select_list(:name,"clientDetailView.educationLevel").select_value("135")
      $ie.select_list(:name,"spouseName.nameType").select_value(nsorftype)
      $ie.text_field(:name,"spouseName.firstName").set(nsorffname)
      $ie.text_field(:name,"spouseName.lastName").set(nsorflname)
      #custom_fields(ncustom)
      $ie.button(:value,@@button_continue).click
      @@c_name=String(nfname)+" "+String(nlname)
      assert($ie.contains_text(@@client_mfi_page_msg))
      $logger.log_results("page redirected to create client enter MFI information","NA","NA","passed")
      rescue Test::Unit::AssertionFailedError=>e
      $logger.log_results("page redirected to create client enter MFI information","NA","NA","Failed")
      rescue =>excp
      quit_on_error(excp) 
    end
  end
  
  #checking for the no of mandatory custom fields
  def custom_fields(ncustom)
    begin
      search_client=$dbh.real_query("SELECT entity_id FROM custom_field_definition  where entity_type=1 and mandatory_flag=1")
      dbresult1=search_client.fetch_row.to_a
      rowl= search_client.num_rows
      rowc=0
      while(rowc < rowl)
        @@entity_id=dbresult1[0]
        if @@entity_id=="10" then
          insert_data_in_to_first_custom_field(ncustom)
        elsif @@entity_id=="58" then
          insert_data_in_to_second_custom_field(ncustom)
        end
        dbresult1=search_client.fetch_row.to_a
        rowc+=1
      end
      rescue =>excp
      quit_on_error(excp) 
    end    
  end
  
  #inserts data into first custom field
  def insert_data_in_to_first_custom_field(ncustom)
    begin
      $ie.text_field(:name,"customField[0].fieldValue").set(ncustom)
    rescue =>excp
      quit_on_error(excp) 
    end
  end
  
  #inserts data into second custom field
  def insert_data_in_to_second_custom_field(ncustom)
    begin
      $ie.text_field(:name,"customField[1].fieldValue").set(ncustom)
    rescue =>excp
      quit_on_error(excp) 
    end
  end
  
  #mandatory check with out formed by in Enter MFI information page
  def check_create_client_mfi_mandatory()
    begin
      $ie.select_list(:name,"formedByPersonnel").select_value("")
      $ie.button(:value,@@button_preview).click
      assert($ie.contains_text(@@client_formedby_msg))
      $logger.log_results("Checked Mandatory_MFI Information","N/A","N/A","Passed")
      rescue Test::Unit::AssertionFailedError=>e
      $logger.log_results("Checked Mandatory_MFI Information","N/A","N/A","Failed")
      rescue =>excp
      quit_on_error(excp) 
    end
  end
  
  #Method for Create client with all mandatory data in Enter MFI information page
  def create_client_enter_mfidata(nsalutation,nfname,nlname,ndate,nmonth,nyear,ngender,nreligion,nsorftype,nsorffname,nsorflname,ncustom)
    begin
      if ($validname=="mifos") then
        dbquery("select personnel_id,display_name from personnel where level_id=1 and office_id="+@@office_id)
        @@personnel_id=dbresult[0]
        @@loan_officer=dbresult[1]
      else
        dbquery("select personnel_id,display_name from personnel where level_id=1 and login_name='"+$validname+"'")
        @@personnel_id=dbresult[0]
        @@loan_officer=dbresult[1]
      end
      @@client_review=@@createclient+" "+@@clientprop['client.CreatePreviewReviewSubmitTitle'].squeeze(" ")
      $ie.select_list(:name,"formedByPersonnel").select_value(@@personnel_id)
      $ie.button(:value,@@button_preview).click
      assert($ie.contains_text(@@client_review)) 
      $logger.log_results("Create client Review&amp;Submit page displaying proper data","N/A","N/A","Passed")
    rescue Test::Unit::AssertionFailedError=>e
      $logger.log_results("Create client Review&amp;Submit page displaying proper data","N/A","N/A","Failed")
     rescue =>excp
      quit_on_error(excp) 
    end
  end
  
  #method for clicking on submit or save for later while creating client
  
  def submit_data(nstatus)
    begin
     # puts "nstatus=>"+nstatus.to_s
      $ie.button(:value,nstatus).click
      @@client_success=@@clientprop['client.ConfirmationMessage']+" "+@@lookup_name_client
      assert($ie.contains_text(@@client_success))
      $logger.log_results("client created successfully","N/A","N/A","Passed")
      go_to_detailspage()
      rescue Test::Unit::AssertionFailedError=>e
      $logger.log_results("client created successfully","N/A","N/A","Failed")
      rescue =>excp
      quit_on_error(excp) 
    end
  end
  
  # Checking that whether View client details now link is working
  
  def go_to_detailspage()
    begin
      @@view_client_details=@@clientprop['client.ViewClientDetailsLink1']+" "+@@lookup_name_client+" "+@@clientprop['client.ViewClientDetailsLink2']
      @@edit_client_status=@@clientprop['client.EditLink']+" "+@@lookup_name_client+" "+@@clientprop['client.StatusLink']
      $ie.link(:text,@@view_client_details).click
      assert($ie.contains_text(@@edit_client_status))
      $logger.log_results("Opened Edit client details page","N/A","N/A","passed")
      change_status()
    rescue Test::Unit::AssertionFailedError=>e
      $logger.log_results("Opened Edit client details page","N/A","N/A","passed")
    rescue =>excp
      quit_on_error(excp) 
    end
  end 
  
  #Changing the staus of client.Getting the current status and what to change
  
  def change_status()

    begin
      dbquery("select status_id from customer where display_name='"+@@c_name+"'")
      status_id=dbresult[0]
      if status_id=="1" then
        change_status_pending()
      elsif status_id=="2" then
        change_status_active()
      end
    rescue =>excp
      quit_on_error(excp) 
    end
  end
  
  
  #Changing the status from patial to pending
  
  def change_status_pending()
    begin
      $ie.link(:text,@@edit_client_status).click
      $ie.radio(:name,"newStatusId","2").set
      $ie.text_field(:name,"notes").set("AAAAA")
      $ie.button(:value,@@button_preview).click
      $ie.button(:value,@@button_submit).click
      dbquery("SELECT lookup_value FROM lookup_value_locale where lookup_id=2 and locale_id=1")
      @@application_pending_approval=dbresult[0]
      assert($ie.contains_text(@@clientprop['client.PerformanceHistoryHeading']))and assert($ie.contains_text(@@application_pending_approval)) 
      $logger.log_results("Status changed to Pending","NA","NA","passed") 
      #view_change_log_pending()
    rescue Test::Unit::AssertionFailedError=>e
      $logger.log_results("Status changed to Pending","NA","NA","failed") 
    rescue =>excp
      quit_on_error(excp) 
    end
  end  
  
  
  #Changing the status from Pending to Active
  
  def change_status_active()
    begin
      $ie.link(:text,@@edit_client_status).click
      $ie.radio(:name,"newStatusId","3").set
      $ie.text_field(:name,"notes").set("AAAAA")
      $ie.button(:value,@@button_preview).click
      $ie.button(:value,@@button_submit).click
      dbquery("SELECT lookup_value FROM lookup_value_locale where lookup_id=3 and locale_id=1")
      @@active=dbresult[0]
      assert($ie.contains_text(@@clientprop['client.PerformanceHistoryHeading']))and assert($ie.contains_text(@@active))
      $logger.log_results("Status changed to Active","NA","NA","passed") 
      #view_change_log_active()
    rescue Test::Unit::AssertionFailedError=>e
      $logger.log_results("Status changed to Active","NA","NA","failed") 
    rescue =>excp
      quit_on_error(excp) 
    end
  end   
  
  
  #checking the change log after changing the status to pending from partial
  
  def view_change_log_pending()
    begin
      @@change_log=@@clientprop['client.ChangeLogLink']
      @@status_label=@@clientprop['client.Status']
      
      $ie.link(:text,@@change_log).click
      dbquery("SELECT lookup_value FROM lookup_value_locale where lookup_id=1 and locale_id=1")
      @@partial_application=dbresult[0]
      assert($ie.contains_text(@@status_label))and assert($ie.contains_text(@@application_pending_approval)) and assert($ie.contains_text(@@partial_application))
      $logger.log_results("View Change Log is displaying proper data","N/A","N/A","Passed") 
      $ie.button(:value,@@return_to_details_page).click 
    rescue Test::Unit::AssertionFailedError=>e
      $logger.log_results("View Change Log is displaying proper data","N/A","N/A","Failed")        
    rescue =>excp
      quit_on_error(excp) 
    end
  end
  
  
  #Checking the change log after changing the status to active from pending
  def view_change_log_active()
    begin
      $ie.link(:text,@@change_log).click
      assert($ie.contains_text(@@status_label))and assert($ie.contains_text(@@application_pending_approval)) and assert($ie.contains_text(@@active))
      $logger.log_results("View Change Log is displaying proper data","N/A","N/A","Passed")   
      $ie.button(:value,@@return_to_details_page).click  
    rescue Test::Unit::AssertionFailedError=>e
      $logger.log_results("View Change Log is displaying proper data","N/A","N/A","Failed")        
    rescue =>excp
      quit_on_error(excp) 
    end
  end
  
  #added method to check for label client charges  
  
  def check_client_charges_label()
    begin
      @@view_details=@@clientprop['client.viewdetails']
      @@client_charges_label=@@member_label+" "+ @@clientprop['client.clientcharges']
      $ie.link(:text,@@view_details).click
      assert($ie.contains_text(@@client_charges_label))and \
      assert($ie.document.body.innerText.scan(@@client_charges_label).size==2)
      $logger.log_results(@@client_charges_label+" label appears for customer type client","NA",@@client_charges_label,"passed")
      $ie.link(:text,@@c_name).click
    rescue Test::Unit::AssertionFailedError=>e
      $logger.log_results(@@client_charges_label+" label does not appear for customer type client","NA",@@client_charges_label,"failed") 
      $ie.link(:text,@@c_name).click
    rescue =>excp
      quit_on_error(excp) 
    end
  end
  
  #checking the database whether the created client is storing in the data base
  
  def db_check()
    begin
      db_center=$dbh.real_query("select * from customer where display_name='"+@@c_name+"' and loan_officer_id="+@@personnel_id+" and branch_id="+@@office_id)
      rowcount= db_center.num_rows
      if rowcount==0 then
        $logger.log_results("Data Base Check","NA","NA","failed") 
      else
        $logger.log_results("Data Base Check","NA","NA","passed")  
      end 
    rescue =>excp
      quit_on_error(excp) 
    end  
  end
  
  #method for create client with all data in enter personal information page
  
  def client_create_with_all_data(nsalutation,nfname,nmname,nsname,nlname,ngovtid,ndate,nmonth,nyear,ngender,npovertystatus,nmstatus,nnoofchildren,nreligion,neducation,nsorftype,nsorffname,nsorfmname,nsorfsname,nsorflname,naddress1,naddress2,naddress3,ncity,nstate,ncountry,npcode,nphone,ncustom)
    begin
      $ie.select_list(:name,"clientName.salutation").select_value(nsalutation)
      $ie.text_field(:name,"clientName.firstName").set(nfname)
      #$ie.text_field(:name,"clientName.middleName").set(nmname)
      #$ie.text_field(:name,"clientName.secondLastName").set(nsname)
      $ie.text_field(:name,"clientName.lastName").set(nlname)
      #$ie.text_field(:name,"governmentId").set(ngovtid)
      $ie.text_field(:name,"dateOfBirthDD").set(ndate)
      $ie.text_field(:name,"dateOfBirthMM").set(nmonth)
      $ie.text_field(:name,"dateOfBirthYY").set(nyear)
      $ie.select_list(:name,"clientDetailView.gender").select_value(ngender)
      $ie.select_list(:name,"clientDetailView.povertyStatus").select_value(npovertystatus)
      $ie.select_list(:name,"clientDetailView.maritalStatus").select_value(nmstatus)
      $ie.text_field(:name,"clientDetailView.numChildren").set(nnoofchildren)    
      $ie.select_list(:name,"clientDetailView.citizenship").select_value(nreligion)
      $ie.select_list(:name,"clientDetailView.educationLevel").select_value(neducation)
      $ie.select_list(:name,"spouseName.nameType").select_value(nsorftype)
      $ie.text_field(:name,"spouseName.firstName").set(nsorffname)
      $ie.text_field(:name,"spouseName.middleName").set(nsorfmname)
      $ie.text_field(:name,"spouseName.secondLastName").set(nsorfsname)
      $ie.text_field(:name,"spouseName.lastName").set(nsorflname)
      #$ie.text_field(:name,"customerAddressDetail.line1").set(naddress1)
      #$ie.text_field(:name,"customerAddressDetail.line2").set(naddress2)
      #$ie.text_field(:name,"customerAddressDetail.line3").set(naddress3)
      #$ie.text_field(:name,"customerAddressDetail.city").set(ncity)
      #$ie.text_field(:name,"customerAddressDetail.state").set(nstate)
      #$ie.text_field(:name,"customerAddressDetail.country").set(ncountry)
      #$ie.text_field(:name,"customerAddressDetail.zip").set(npcode)
      #$ie.text_field(:name,"customerAddressDetail.phoneNumber").set(nphone)
      #custom_fields(ncustom)
      #@@c_name=String(nfname)+" "+String(nmname)+" "+String(nsname)+" "+String(nlname)
      @@c_name=String(nfname)+" "+String(nlname)
      rescue =>excp
      quit_on_error(excp) 
    end
  end
  
  #method for click on continue button 
  
  def click_continue() 
    begin
      $ie.button(:value,@@button_continue).click
      assert($ie.contains_text(@@client_mfi_page_msg))
      $logger.log_results("page redirected to create client enter MFI information","NA","NA","passed")
    rescue Test::Unit::AssertionFailedError=>e
      $logger.log_results("page redirected to create client enter MFI information","NA","NA","passed")
    rescue =>excp
      quit_on_error(excp) 
    end
  end 
  
  #method for create client with all MFI information in Enter MFI information page
  
  def client_create_enter_all_data_mfi(nexternalid,ntdate,ntmonth,ntyear)
    begin
      $ie.select_list(:name,"formedByPersonnel").select_value(@@personnel_id)
      $ie.text_field(:name,"externalId").set(nexternalid)
      $ie.checkbox(:name,"trained","1").set
      $ie.text_field(:name,"trainedDateDD").set(ntdate)
      $ie.text_field(:name,"trainedDateMM").set(ntmonth)      
      $ie.text_field(:name,"trainedDateYY").set(ntyear)
      fee_select_one_by_one()
    rescue =>excp
      quit_on_error(excp) 
    end
  end   
  #selecting fee one by one while creating center
  
  def fee_select_one_by_one()
    begin
      #search_res=$dbh.real_query("select * from fees where category_id=2 and default_admin_fee='no' and status=1")
      search_res=$dbh.real_query("select a.fee_id,a.fee_name,c.recurrence_id from fees a,fee_frequency b,recurrence_detail c where a.fee_id=b.fee_id and (b.frequency_meeting_id=c.meeting_id or b.frequency_meeting_id is null )and c.recurrence_id=(select recurrence_id from recurrence_detail a ,customer_meeting cm where a.meeting_id=cm.meeting_id and customer_id = "+@@customer_id+") and a.fee_id not in (select fee_id from feelevel) and a.category_id in (1,2) and status=1 group by a.fee_id")
      dbresult1=search_res.fetch_row.to_a
      row1=search_res.num_rows()
      rowf=0
      number=3
      if row1=="0" then
        $logger.log_results("No Fees created for the group","NA","NA","Passed")
      elsif row1 < number then
        while (rowf < row1)
          fee_id=dbresult1[0]
          $ie.select_list(:name,"selectedFee["+String(rowf)+"].feeId").select_value(fee_id)
          dbresult1=search_res.fetch_row.to_a
          rowf+=1
        end
      else
        while(rowf < number)
          fee_id=dbresult1[0]
          $ie.select_list(:name,"selectedFee["+String(rowf)+"].feeId").select_value(fee_id)
          dbresult1=search_res.fetch_row.to_a
          rowf+=1
        end
      end
    rescue =>excp
      quit_on_error(excp)
    end
  end
  
  #method for click on Preview button
  
  def click_preview()
    begin
      $ie.button(:value,@@button_preview).click
      assert($ie.contains_text(@@client_review)) 
      $logger.log_results("Create client Review&amp;Submit page displaying proper data","N/A","N/A","Passed")
    rescue Test::Unit::AssertionFailedError=>e
      $logger.log_results("Create client Review&amp;Submit page displaying proper data","N/A","N/A","Failed")
    rescue =>excp
      quit_on_error(excp) 
    end
  end
  
  #Editing the client personal information from the review page
  
  def edit_personal_information_from_review(nsalutation,nfname,nmname,nsname,nlname,ngovtid,ndate,nmonth,nyear,ngender,npovertystatus,nmstatus,nnoofchildren,nreligion,neducation,nsorftype,nsorffname,nsorfmname,nsorfsname,nsorflname,naddress1,naddress2,naddress3,ncity,nstate,ncountry,npcode,nphone,ncustom)
    begin
      @@client_edit_personnel=@@clientprop['client.CreateTitle']+" "+@@lookup_name_client+" "+@@clientprop['client.CreatePersonalInformationTitle'].squeeze(" ")
      $ie.button(:value,@@clientprop['button.previousPersonalInfo']).click
      assert($ie.contains_text(@@client_edit_personnel))
      $logger.log_results("Page redirected to Manage client-edit personnel information","N/A","N/A","Passed")
      client_create_with_all_data(nsalutation,nfname,nmname,nsname,nlname,ngovtid,ndate,nmonth,nyear,ngender,npovertystatus,nmstatus,nnoofchildren,nreligion,neducation,nsorftype,nsorffname,nsorfmname,nsorfsname,nsorflname,naddress1,naddress2,naddress3,ncity,nstate,ncountry,npcode,nphone,ncustom)
      click_preview()
    rescue Test::Unit::AssertionFailedError=>e
      $logger.log_results("Page redirected to Manage client-edit personnel information","N/A","N/A","Failed")
      client_create_with_all_data(nsalutation,nfname,nmname,nsname,nlname,ngovtid,ndate,nmonth,nyear,ngender,npovertystatus,nmstatus,nnoofchildren,nreligion,neducation,nsorftype,nsorffname,nsorfmname,nsorfsname,nsorflname,naddress1,naddress2,naddress3,ncity,nstate,ncountry,npcode,nphone,ncustom)
      click_preview()
    rescue =>excp
      quit_on_error(excp)   
    end
  end
  
  #Editing the client MFI information from review page
  
  def edit_mfi_information_from_review(nexternalid,ntdate,ntmonth,ntyear)
    begin
      @@client_edit_mfi=@@clientprop['client.CreateTitle']+" "+@@lookup_name_client+" "+@@clientprop['client.CreateMfiInformationTitle'].squeeze(" ")

      $ie.button(:value,@@clientprop['button.previousMFIInfo']).click
      assert($ie.contains_text(@@client_edit_mfi))
      $logger.log_results("Page redirected to Manage client-edit MFI information","N/A","N/A","Passed")
      client_create_enter_all_data_mfi(nexternalid,ntdate,ntmonth,ntyear)
      click_preview()
    rescue Test::Unit::AssertionFailedError=>e
      $logger.log_results("Page redirected to Manage client-edit MFI information","N/A","N/A","Failed")
      client_create_enter_all_data_mfi(nexternalid,ntdate,ntmonth,ntyear)
      click_preview()
    rescue =>excp
      quit_on_error(excp) 
    end
  end
  
  #Search for the client from clients accounts page
  
  def search_client_from_clients_accounts_page()
    begin
      dbquery("select global_cust_num from customer where display_name='"+@@c_name+"'")
      global_account_number=dbresult[0]
      $ie.link(:text,"Clients & Accounts").click
      $ie.text_field(:name,"searchString").set(global_account_number)
      $ie.button("Search").click
      $ie.button("Search").click
      search_name=@@c_name+": ID "+global_account_number
      $ie.link(:text,search_name).click
      assert($ie.contains_text(@@clientprop['client.PerformanceHistoryHeading']))
      $logger.log_results("client Details page","Open","opened","passed")
    rescue Test::Unit::AssertionFailedError=>e
      $logger.log_results("client Details page","Open","not opened","failed")
    rescue =>excp
      quit_on_error(excp) 
    end
  end
  
  #Checking whether Edit personal information link is working 
  
  def check_edit_client_personalinformation_link_from_details_page()
    begin
      $ie.link(:text,@@clientprop['client.EditPersonalInformationLink']).click
      @@client_name=(@@c_name+" "+@@clientprop['client.EditPersonalInformationTitle']).squeeze(" ")
      assert($ie.contains_text(@@client_name))
      $logger.log_results("client Details page-Edit Personnel Information","Open","opened","passed")
      $ie.button(:value,@@button_cancel).click
    rescue Test::Unit::AssertionFailedError=>e
      $logger.log_results("client Details page-Edit Personnel Information","Open","opened","failed")
    rescue =>excp
      quit_on_error(excp) 
    end
  end
  
  #Editing the client personnel information from clients details page
  
  def edit_client_personnel_enter_data(nsalutation,nfname,nmname,nsname,nlname,ngovtid,ndate,nmonth,nyear,ngender,npovertystatus,nmstatus,nnoofchildren,nreligion,neducation,nsorftype,nsorffname,nsorfmname,nsorfsname,nsorflname,naddress1,naddress2,naddress3,ncity,nstate,ncountry,npcode,nphone,ncustom)
    begin
      @@edit_personnel=@@clientprop['client.EditPersonalInformationLink']
      $ie.link(:text,@@edit_personnel).click
      $ie.select_list(:name,"clientName.salutation").select_value(nsalutation)
      $ie.text_field(:name,"clientName.firstName").set(nfname)
      #$ie.text_field(:name,"clientName.middleName").set(nmname)
      #$ie.text_field(:name,"clientName.secondLastName").set(nsname)
      $ie.text_field(:name,"clientName.lastName").set(nlname)
      $ie.select_list(:name,"clientDetailView.gender").select_value(ngender)
      $ie.select_list(:name,"clientDetailView.povertyStatus").select_value(npovertystatus)
      $ie.select_list(:name,"clientDetailView.maritalStatus").select_value(nmstatus)
      $ie.text_field(:name,"clientDetailView.numChildren").set(nnoofchildren)    
      $ie.select_list(:name,"clientDetailView.citizenship").select_value(nreligion)
      $ie.select_list(:name,"clientDetailView.educationLevel").select_value(neducation)
      $ie.select_list(:name,"spouseName.nameType").select_value(nsorftype)
      $ie.text_field(:name,"spouseName.firstName").set(nsorffname)
      $ie.text_field(:name,"spouseName.middleName").set(nsorfmname)
      $ie.text_field(:name,"spouseName.secondLastName").set(nsorfsname)
      $ie.text_field(:name,"spouseName.lastName").set(nsorflname)
      #$ie.text_field(:name,"customerAddressDetail.line1").set(naddress1)
      #$ie.text_field(:name,"customerAddressDetail.line2").set(naddress2)
      #$ie.text_field(:name,"customerAddressDetail.line3").set(naddress3)
      #$ie.text_field(:name,"customerAddressDetail.city").set(ncity)
      #$ie.text_field(:name,"customerAddressDetail.state").set(nstate)
      #$ie.text_field(:name,"customerAddressDetail.country").set(ncountry)
      #$ie.text_field(:name,"customerAddressDetail.zip").set(npcode)
      #$ie.text_field(:name,"customerAddressDetail.phoneNumber").set(nphone)
      #custom_fields(ncustom)
      $ie.button(:value,@@button_preview).click
      assert($ie.contains_text(@@clientprop['client.EditPreviewPersonalReviewTitle']))
      $logger.log_results("Edit Personnel from details page--review&amp;submit personal information page","n/a","n/a","passed")
      $ie.button(:value,@@button_submit).click
    rescue Test::Unit::AssertionFailedError=>e
      $logger.log_results("Edit Personnel from details page--review&amp;submit personal information page","n/a","n/a","failed")
    rescue =>excp
      quit_on_error(excp)
    end
  end
  
  #checking whether Edit MFI information link working
  def check_edit_client_mfi_data_link_from_details_page()
    begin
      @@edit_mfi=@@clientprop['client.EditMfiInformationLink']
      $ie.link(:text,@@edit_mfi).click
      assert($ie.contains_text(@@edit_mfi))
      $logger.log_results("client Details page-Edit MFI Information","Open","opened","passed")
      $ie.button(:value,@@button_cancel).click
    rescue Test::Unit::AssertionFailedError=>e
      $logger.log_results("client Details page-Edit MFI Information","Open","opened","failed")
    rescue =>excp
      quit_on_error(excp) 
    end
  end
  
  #editing the MFI information from clients details page
  def edit_client_mfi_enter_data(nexternalid)
    begin
      @@review_mfi=@@clientprop['client.PreviewMFIInformation']
      $ie.link(:text,@@edit_mfi).click
      $ie.text_field(:name,"externalId").set(nexternalid)
      $ie.button(:value,@@button_preview).click
      assert($ie.contains_text(@@review_mfi))
      $logger.log_results("Edit Personnel from details page--review&amp;submit MFI information page","n/a","n/a","passed")
      $ie.button(:value,@@button_submit).click
    rescue Test::Unit::AssertionFailedError=>e
      $logger.log_results("Edit Personnel from details page--review&amp;submit MFI information page","n/a","n/a","Failed")
    rescue =>excp
      quit_on_error(excp) 
    end
  end
  
  #Checking whether the Edit Group membership link is existed
  def check_edit_group_membership_link()
    begin
      assert($ie.contains_text(@@edit_group_client))
      $logger.log_results("Edit group membership link Exists",@@edit_group_client,@@edit_group_client,"Passed")
    rescue Test::Unit::AssertionFailedError=>e
      $logger.log_results("Edit group membership link Exists",@@edit_group_client,@@edit_group_client,"Failed")    
    rescue =>excp
      quit_on_error(excp) 
    end
  end
  
  
  #Checking whether the Edit Group membership link is working
  def click_edit_group_membership_link()
    begin
      $ie.link(:text,@@edit_group_client).click
      assert($ie.contains_text(@@change_group_membership))
      $logger.log_results("Edit group membership link working","should work","working","Passed")
    rescue Test::Unit::AssertionFailedError=>e
      $logger.log_results("Edit group membership link working","should work","not working","failed")
    rescue =>excp
      quit_on_error(excp) 
    end
  end
  
  #Changing the group membership
  def edit_group_membership()
    begin
      dbquery("select display_name from customer where customer_level_id=2 and status_id=9 and branch_id="+@@office_id+" and display_name not in ('"+@@gdisplay_name+"')")
      groupname=dbresult[0]
      $ie.text_field(:index,2).set(groupname)
      $ie.button(:index,2).click
      $ie.link(:text,groupname).click
      assert($ie.contains_text(@@edit_group_client))
      $logger.log_results("Change Group Membership confirm page","N/A","N/A","Passed")    
      $ie.button(:value,@@button_submit).click
    rescue Test::Unit::AssertionFailedError=>e
      $logger.log_results("Change Group Membership confirm page","N/A","N/A","Failed")    
    rescue =>excp
      quit_on_error(excp)    
    end
  end
  
  # checking whether view summarized historical Data link exist
  def check_view_summarized_historical_Data_link_exist()
    begin
      @@historical_data_link=@@clientprop['client.HistoricalDataLink']
      $ie.wait
      assert($ie.contains_text(@@historical_data_link))
      $logger.log_results("View Summarized Historical Data","Should exist","Existed","Passed")
    rescue Test::Unit::AssertionFailedError=>e
      $logger.log_results("View Summarized Historical Data","Should exist","Existed","Failed")
    rescue =>excp
      quit_on_error(excp) 
    end
  end
  
  # checking whether view summarized historical Data link exist
  def check_view_summarized_historical_Data_link_functionality()
    begin
      @@historical_data_link=@@clientprop['client.HistoricalDataLink']
      $ie.link(:text,@@historical_data_link).click
      text_to_check=@@c_name+" - "+@@customerprop['label.historicaldata']
      assert($ie.contains_text(@@customerprop['label.add_edit_hd']))
      $logger.log_results("View Summarized Historical Data","Should work","Working","Passed")
      $ie.button(:value,@@return_to_details_page).click
    rescue Test::Unit::AssertionFailedError=>e
      $logger.log_results("View Summarized Historical Data","Should work","Working","Failed")
      $ie.button(:value,@@return_to_details_page).click
    rescue =>excp
      quit_on_error(excp) 
    end
  end
  
  #Checking that View all closed accounts existed 
  def check_view_all_closed_accounts_link()
    begin
      @@view_all_closed_accounts_client=@@clientprop['client.ClosedAccountsLink']
      assert($ie.contains_text(@@view_all_closed_accounts_client))
      $logger.log_results("View all closed accounts link existed","NA","NA","passed")
    rescue Test::Unit::AssertionFailedError=>e
      $logger.log_results("View all closed accounts link existed","NA","NA","failed")    
    rescue =>excp
      quit_on_error(excp) 
    end
  end
  
  #Checking that View all closed accountsworking
  def click_view_all_closed_accounts_link
    begin
      $ie.link(:text,@@view_all_closed_accounts_client).click
      assert($ie.contains_text("- "+@@clientprop['client.closedacc']))    
      $logger.log_results("View all closed accounts link working","NA","NA","passed")
      $ie.button(:value,@@return_to_details_page).click
    rescue Test::Unit::AssertionFailedError=>e
      $logger.log_results("View all closed accounts link working","NA","NA","failed")   
    rescue =>excp
      quit_on_error(excp) 
    end
    
  end
  
  #Checking for add notes link
  def check_add_notes_link()
    begin
      @@notes=@@clientprop['client.NotesLink'].squeeze(" ")
      assert($ie.contains_text(@@notes))
      $logger.log_results("Link "+@@clientprop['client.NotesLink'],"Should Exist","Existed","passed")
    rescue Test::Unit::AssertionFailedError=>e
      $logger.log_results("Link "+@@clientprop['client.NotesLink'],"Should Exist","Not Existed","Failed")
    rescue =>excp
      quit_on_error(excp) 
    end
  end
  
  #Clicking on Add notes link
  def click_add_notes_link()
    begin
      $ie.link(:text,@@notes).click
      assert($ie.contains_text(@@c_name+" - "+@@customerprop['Customer.addnoteheading']))
      $logger.log_results("Link "+@@clientprop['client.NotesLink'],"Should Work","Working","passed")
    rescue Test::Unit::AssertionFailedError=>e
      $logger.log_results("Link "+@@clientprop['client.NotesLink'],"Should Work","Not Working","Failed")
    rescue =>excp
      quit_on_error(excp) 
    end
  end
  
  #Checking for the mandatory fields in add notes page
  def check_mandatory_in_add_notes_page()
    begin
      $ie.button(:value,@@button_preview).click
      assert($ie.contains_text(@@client_note_msg))
      $logger.log_results("Mandatory Check when you don't enter any note","N/A","N/A","Passed")
    rescue Test::Unit::AssertionFailedError=>e
      $logger.log_results("Mandatory Check when you don't enter any note","N/A","N/A","Failed")
    rescue =>excp
      quit_on_error(excp) 
    end
  end
  
  #Checking for boundary condition for the field notes
  def enter_more_data_in_notes_field(nnotes)
    begin
      $ie.text_field(:name,"comment").set(nnotes)
      $ie.button(:value,@@button_preview).click
      @@client_note_error_message="The maximum length for Note field is"+" 500"
      assert($ie.contains_text(@@client_note_error_message))
      $logger.log_results("Boundary Check for Notes ","Should display Proper Error Message","Displaying","Passed")
    rescue Test::Unit::AssertionFailedError=>e
      $logger.log_results("Boundary Check for Notes ","Should display Proper Error Message","Not Displaying","Failed")    
    rescue =>excp
      quit_on_error(excp) 
    end
  end
  
  #Adding a note to the customer record
  def enter_data_in_add_note()
    begin
      $ie.text_field(:name,"comment").set("Adding A note")
      $ie.button(:value,@@button_preview).click
      assert($ie.contains_text(@@c_name+" - "+@@customerprop['Customer.PreviewNote']))
      $logger.log_results("Page Redirected to Preview page","N/A","N/A","Passed")
      $ie.button(:value,@@button_submit).click
    rescue Test::Unit::AssertionFailedError=>e
      $logger.log_results("Page not Redirected to Preview page","N/A","N/A","Failed")
      $ie.button(:value,@@button_submit).click
    rescue =>excp
      quit_on_error(excp) 
    end
  end
  
  #Check for see all notes link
  def check_for_see_all_notes_link
    begin
      #$ie.wait(10)
      assert($ie.contains_text(@@clientprop['client.SeeAllNotesLink']))
      $logger.log_results(@@clientprop['client.SeeAllNotesLink'],"Link should Exist","Existed","Passed")
    rescue Test::Unit::AssertionFailedError=>e
      $logger.log_results(@@clientprop['client.SeeAllNotesLink'],"Link should Exist","Not Existed","Failed")
    rescue =>excp
      quit_on_error(excp) 
    end
  end
  
  #Click on see all notes link and check the functionality
  def click_see_all_notes_link()
    begin 
      $ie.link(:text,@@clientprop['client.SeeAllNotesLink']).click
      assert($ie.contains_text(@@c_name+"  - "+@@customerprop['Customer.addnoteheading']))
      $logger.log_results(@@clientprop['client.SeeAllNotesLink'],"Link should Work","Working","Passed")
      $ie.link(:text,@@c_name).click
    rescue Test::Unit::AssertionFailedError=>e
      $logger.log_results(@@clientprop['client.SeeAllNotesLink'],"Link should Work","Not Working","Failed")
    rescue =>excp
      quit_on_error(excp) 
    end
  end
  
  #Checking that Click here to continue if Group membership is not required for your client is existed
  def check_create_client_out_of_group_link()
    begin
      $ie.link(:text,"Clients & Accounts").click
      $ie.link(:text,@@createclientlabel).click
      assert($ie.contains_text(@@member_outof_group_link))
      $logger.log_results("Create client Out of group link","Should exist","Existed","Passed")
    rescue Test::Unit::AssertionFailedError=>e
      $logger.log_results("Create client Out of group link","Should exist","Existed","Failed")
    rescue =>excp
      quit_on_error(excp) 
    end
  end
  
  #Checking that Click here to continue if Group membership is not required for your client is working
  def click_create_client_out_of_group_link() 
    begin
      $ie.link(:text,@@member_outof_group_link+".").click
      assert($ie.contains_text(@@Member_select_branch_msg))
      $logger.log_results("Page select branch out of group","Should appear","appeared","passed")
      #$ie.link(:text,@@display_name).click
    rescue Test::Unit::AssertionFailedError=>e
      $logger.log_results("Page select branch out of group","Should appear","not appeared","failed")
    rescue =>excp
      quit_on_error(excp) 
    end
  end
  
  
  #Create client out side the group with all mandatory data
  
  def create_client_out_of_group(nsalutation,nfname,nmname,nsname,nlname,ngovtid,ndate,nmonth,nyear,ngender,npovertystatus,nmstatus,nnoofchildren,nreligion,neducation,nsorftype,nsorffname,nsorfmname,nsorfsname,nsorflname,naddress1,naddress2,naddress3,ncity,nstate,ncountry,npcode,nphone,ncustom,nexternalid,ntdate,ntmonth,ntyear)
    begin
      select_office()
      client_create_with_all_data(nsalutation,nfname,nmname,nsname,nlname,ngovtid,ndate,nmonth,nyear,ngender,npovertystatus,nmstatus,nnoofchildren,nreligion,neducation,nsorftype,nsorffname,nsorfmname,nsorfsname,nsorflname,naddress1,naddress2,naddress3,ncity,nstate,ncountry,npcode,nphone,ncustom)
      click_continue() 
      if(@frequncymeeting.to_i==2) then # for month
        client_create_enter_all_data_mfi(nexternalid,ntdate,ntmonth,ntyear)
      elsif(@frequncymeeting.to_i==1) then # for week
        client_create_enter_all_data_mfi_outofgroup(nexternalid,ntdate,ntmonth,ntyear)
      end
    rescue =>excp
      quit_on_error(excp)   
    end
  end
  
  # seperate function for out of group members
  
  def client_create_enter_all_data_mfi_outofgroup(nexternalid,ntdate,ntmonth,ntyear)
    begin
      $ie.select_list(:name,"formedByPersonnel").select_value(@@personnel_id)
      $ie.text_field(:name,"externalId").set(nexternalid)
      $ie.checkbox(:name,"trained","1").set
      $ie.text_field(:name,"trainedDateDD").set(ntdate)
      $ie.text_field(:name,"trainedDateMM").set(ntmonth)      
      $ie.text_field(:name,"trainedDateYY").set(ntyear)
      fee_select_one_by_one_outofgroup()
    rescue =>excp
      quit_on_error(excp) 
    end
  end
  #Selecting the loan officer while entering MFI information
  
  def select_loan_officer()
    begin
      $ie.select_list(:name,"loanOfficerId").select_value(@@personnel_id)
      meeting(@@lookup_name_client)
    rescue =>excp
      quit_on_error(excp) 
    end
  end
  
  # selecting fee for clients out of group
  def   fee_select_one_by_one_outofgroup()
    begin
      search_res=$dbh.real_query("select a.fee_id,a.fee_name,c.recurrence_id from fees a,fee_frequency b,recurrence_detail c where a.fee_id=b.fee_id and (b.frequency_meeting_id=c.meeting_id or b.frequency_meeting_id is null )and c.recurrence_id=1 and a.fee_id not in (select fee_id from feelevel) and category_id in (1,2) and status=1 group by a.fee_id")
      dbresult1=search_res.fetch_row.to_a
      row1=search_res.num_rows()
      rowf=0
      number=3
      if row1=="0" then
        $looger.log_results("No Fess created for the group","","","Passed")
      elsif row1 < number then
        while (rowf < row1)
          fee_id=dbresult1[0]
          $ie.select_list(:name,"selectedFee["+String(rowf)+"].feeId").select_value(fee_id)
          dbresult1=search_res.fetch_row.to_a
          rowf+=1
        end
      else
        while(rowf < number)
          fee_id=dbresult1[0]
          $ie.select_list(:name,"selectedFee["+String(rowf)+"].feeId").select_value(fee_id)
          dbresult1=search_res.fetch_row.to_a
          rowf+=1
        end
      end
    rescue =>excp
      quit_on_error(excp) 
    end
  end
  
  # Selecting Branch office while creating client out side group
  def select_office()
    begin
      dbquery("select office_id,display_name from office where status_id=1 and office_level_id=5 and  search_id like '"+@@search_id+"%'")
      @@office_id=dbresult[0]
      display_name=dbresult[1]
      if (display_name=="Mifos HO") then
        get_next_data
        @@office_id=dbresult[0]
        display_name=dbresult[1]
      end   
      $ie.link(:text,display_name).click 
      $ie.wait
      @@createclient=@@clientprop['client.CreateTitle']+" "+@@lookup_name_client
      @@client_select_client=(@@createclient+" "+@@clientprop['client.CreatePersonalInformationTitle']).squeeze(" ")
      assert($ie.contains_text(@@client_select_client))
      $logger.log_results("page redirected to",@@client_select_client,"Page","Passed")
    rescue Test::Unit::AssertionFailedError=>e
      $logger.log_results("page redirected to",@@client_select_client,"Page","Failed")
    rescue =>excp
      quit_on_error(excp) 
    end      
  end
  
  #Checking that create client with out admin fee
  def client_create_remove_admin_fee_from_review_page()
    begin
      $ie.button(:value,@@clientprop['button.previousMFIInfo']).click
      search_fee=$dbh.real_query("select * from fees where category_id=2 and default_admin_fee='yes' and status=1")
      dbresult1=search_fee.fetch_row.to_a
      no_of_fee=search_fee.num_rows()
      rowf=0
      if no_of_fee=="0" then
        $logger.log_results("No Fess created for the group","","","Passed")
      else
        while (rowf < no_of_fee)
          fee_id=dbresult1[0]
          $ie.checkbox(:name,"adminFee["+String(rowf)+"].checkedFee")
          dbresult1=search_res.fetch_row.to_a
          rowf+=1
        end
      end     
      click_preview()
    rescue =>excp
      quit_on_error(excp) 
    end
  end
  
  #Check for edit branch membership link exist
  def check_edit_branch_member_link_exist()
    begin
      assert($ie.contains_text(@@edit_branch_membership_link))
      $logger.log_results("Link","Edit branch membership","Should exist","Passed")
    rescue Test::Unit::AssertionFailedError=>e
      $logger.log_results("Link","Edit branch membership","Should exist","Failed")
    rescue =>excp
      quit_on_error(excp) 
    end
  end
  
  #Check for edit branch membership link working
  def check_edit_branch_member_link_functionality()
    begin
      $ie.link(:text,@@edit_branch_membership_link).click
      assert($ie.contains_text(@@c_name+" - "+@@edit_branch_membership_link))
      $logger.log_results("Link","Edit branch membership","Should Work","Passed")
    rescue Test::Unit::AssertionFailedError=>e
      $logger.log_results("Link","Edit branch membership","Not Working","Failed")
    rescue =>excp
      quit_on_error(excp) 
    end
    
  end
  
  #Editing branch membership 
  def edit_branch_membership()
    begin
      dbquery("select office_id,display_name from office where status_id=1 and office_level_id=5 and office_id not in ('"+@@office_id+"')")
      @@office_name=dbresult[1]
      $ie.link(:text,@@office_name).click
      $ie.wait(10)
      @@header=(@@c_name+" - "+@@clientprop['client.EditPreviewPersonalReviewTitle']).squeeze(" ")
      assert($ie.contains_text(@@header))
      $logger.log_results("Change Branch Membership confirm page","N/A","N/A","Passed")    
      $ie.button(:value,@@button_submit).click
    rescue Test::Unit::AssertionFailedError=>e
      $logger.log_results("Change Branch Membership confirm page","N/A","N/A","Failed")    
    rescue =>excp
      quit_on_error(excp) 
    end
  end
  
  #Meeting Creation
  def create_meeting(frequncymeeting,monthtype,reccurweek,weekweekday,monthday,monthmonth,monthrank,monthweek,monthmonthrank,meetingplace)
    begin
      
      if frequncymeeting=="1" then
        $ie.radio(:name,"frequency","1").set
        $ie.text_field(:name,"recurWeek").set(reccurweek)
        $ie.select_list(:name,"weekDay").select_value(weekweekday)
        $ie.text_field(:name,"meetingPlace").set(meetingplace)
        $ie.button(:value,@@meetingprop['meeting.button.save']).click
      elsif frequncymeeting=="2" then
        $ie.radio(:name,"frequency","2").set
        if monthtype=="1" then
          $ie.radio(:name,"monthType","1").set
          $ie.text_field(:name,"monthDay").set(monthday)
          $ie.text_field(:name,"dayRecurMonth").set(monthmonth)
          $ie.text_field(:name,"meetingPlace").set(meetingplace)
          $ie.button(:value,@@meetingprop['meeting.button.save']).click
        elsif monthtype=="2" then
          $ie.select_list(:name,"monthRank").select_value(monthrank)
          $ie.select_list(:name,"monthWeek").select_value(monthweek)
          $ie.text_field(:name,"monthMonthRank").set(monthmonthrank)
          $ie.text_field(:name,"meetingPlace").set(meetingplace)
          $ie.button(:value,@@meetingprop['meeting.button.save']).click
        end
      end
      assert($ie.contains_text(@@clientprop['client.AdministrativeFeesHeading']))
      $logger.log_results("Meeting creation","NA","NA","passed");
    rescue Test::Unit::AssertionFailedError=>e
      $logger.log_results("Meeting creation","NA","NA","failed");
    rescue =>excp
      quit_on_error(excp) 
    end
    
  end
 
 #added bu Dilip  as part of bug#577
def check_applyfee()
    
    #The below query will find the customer for whom the periodic fees has been removed ie fee_status=2
    count=count_records("select count(global_cust_num) from customer where customer_id in (select distinct customer_id from account a, customer_account ca where a.account_id=ca.account_id and a.account_id   in (select distinct account_id from account_fees where fee_status=2)) and CUSTOMER_LEVEL_ID = 1 and status_id in (1,2,3,4)")
    if(count.to_i>0) then
      applycharges()
      check_blueband_links
    else
    applycustomerfee()
    applycharges()
    check_blueband_links
    end #end if    
    
  end # end of check_applyfee function
  
  #function to apply charges to a client added by Dilip as part of Bug#577 on 1/10/2006
  
  def applycharges()
       dbquery("select global_cust_num,display_name from customer where customer_id in (select distinct customer_id from account a, customer_account ca where a.account_id=ca.account_id and a.account_id   in (select distinct account_id from account_fees where fee_status=2)) and CUSTOMER_LEVEL_ID = 1 and status_id in (1,2,3,4)")
        @@global_cust_num=dbresult[0]
        @@Display_name=dbresult[1]
        search_client @@global_cust_num
        $ie.link(:text,@@Display_name+": ID "+@@global_cust_num).click
        $ie.link(:text,@@view_details).click
        $ie.link(:text,@@member_applycharges2).click
        feetypearr=$ie.select_list(:name,"chargeType").getAllContents()
        $ie.select_list(:name,"chargeType").select(feetypearr[1].to_s)
        #    arr=$ie.select_list(:name,"chargeType").getSelectedItems()
        $ie.button(:value,"Submit").click
        begin
          assert($ie.contains_text(@@member_applycharges2))
          $logger.log_results("Apply Charges Link check","Should work","Working","Passed")
          table_obj=$ie.table(:index,16)
          begin
            assert(table_obj[2][2].text==feetypearr[1].to_s.strip+" applied")
            $logger.log_results("Bug#577- Issue2-Fee name display","Apply a fees to customer","Fee name should be displayed","Passed")        
            rescue Test::Unit::AssertionFailedError=>e
            $logger.log_results("Bug#577- Issue2-Fee name display","Apply a fees to customer","Fee name is not displayed","failed")       
            rescue =>excp
            quit_on_error(excp)
          end
          rescue Test::Unit::AssertionFailedError=>e
          $logger.log_results("Apply Charges Link check","NA","NA","failed")
          rescue =>excp
           quit_on_error(excp)
        end
        
       click_removeFee
  end #end of applycharges

# function to apply fees to a cutomer in this case its a member added by Dilip on 1/10/2006

  def applycustomerfee()
  
    dbquery("select display_name,global_cust_num from customer where customer_level_id=1 and status_id in (1,2,3,4) order by customer_id desc")
    globalcustnum=dbresult[1]
    displayname=dbresult[0]
    search_client(globalcustnum)
     $ie.link(:text,displayname+": ID "+globalcustnum).click
     $ie.link(:text,@@view_details).click
     $ie.link(:text,@@member_applycharges1).click
     feetypearr=$ie.select_list(:name,"chargeType").getAllContents()
     $ie.select_list(:name,"chargeType").select(feetypearr[1].to_s)
     
  end
  
  #Added as part of Bug#577.
  def click_removeFee()
    
    $ie.link(:text,"remove").click
    table_obj=$ie.table(:index,16)
    assert(table_obj[2][3].text=="-")
    $logger.log_results("Bug#577-issue4-Remove peridic Fee of a customer","Should display -","Working","Passed")
    rescue Test::Unit::AssertionFailedError=>e
    $logger.log_results("Bug#577-issue4-Remove peridic Fee of a customer","NA","NA","failed")
    rescue =>excp
    quit_on_error(excp)
    
  end
  
  #function added as part of bug#577 by Dilip on 1/10/2006
def check_blueband_links

    #query which retreives the group/center of the given client.
    dbquery("select ch1.display_name as kendra,ch2.display_name as grp,ch3.display_name as member from customer ch3 join customer ch2 on ch3.parent_customer_id=ch2.customer_id join  customer ch1 on ch2.parent_customer_id=ch1.customer_id where ch3.global_cust_num='"+@@global_cust_num+"'")
    @kendraname=dbresult[0]
    @groupname=dbresult[1]
    @membername=dbresult[2]
    
    begin
      assert($ie.contains_text(@kendraname))
      $logger.log_results("Bug#577- Issue3-Center name check","Center name to be present on the blue band","Center name present on the blue band","passed")
      rescue Test::Unit::AssertionFailedError=>e
      $logger.log_results("Bug#577- Issue3-Center name check","Center name to be present on the blue band","Center name not present on the blue band","failed")
    end
    
    begin    
      assert($ie.contains_text(@groupname))
      $logger.log_results("Bug#577- Issue3-Group name check","Group name to be present on the blue band","Group name present on the blue band","passed")
      rescue Test::Unit::AssertionFailedError=>e
      $logger.log_results("Bug#577- Issue3-Group name check","Group name to be present on the blue band","Group name not present on the blue band","failed")
    end
    
    begin
      assert($ie.contains_text(@membername))
      $logger.log_results("Bug#577- Issue3-Member name check","Member name to be present on the blue band","Member name present on the blue band","passed")
      rescue Test::Unit::AssertionFailedError=>e
      $logger.log_results("Bug#577- Issue3-Member name check","Member name to be present on the blue band","Member name not present on the blue band","failed")
    end
    
    $ie.link(:text,@membername).click
    
    assert($ie.contains_text("Edit Member status"))
    $logger.log_results("Bug#577- Issue3-Click on Member link","should work","should work","passed")            
    rescue Test::Unit::AssertionFailedError=>e
    $logger.log_results("Bug#577- Issue3-Click on Member link","should work","should not work","failed")
    rescue =>excp
    quit_on_error(excp)
    
  end #end of check_blueband_links



#function added as part of bug#277 by Dilip on 1/10/2006.Apply misc/penalty fees  to a client
def apply_miscfees(fee_type)
    
    dbquery("Select Display_name,global_cust_num from Customer where Status_ID in (3,4) and CUSTOMER_LEVEL_ID = 1")
    @@Display_name=dbresult[0]
    @@global_cust_num=dbresult[1]
    search_client @@global_cust_num
    $ie.link(:text,@@Display_name+": ID "+@@global_cust_num).click
    $ie.link(:text,@@view_details).click
    $ie.link(:text,"Apply Charges").click
    if(fee_type=="-1")
      $ie.select_list(:name,"chargeType").select_value("-1")
    elsif(fee_type=="-2")
      $ie.select_list(:name,"chargeType").select_value("-2")
    end
    $ie.text_field(:name,"chargeAmount").set("34")
    $ie.button(:value,"Submit").click
    assert($ie.contains_text("Account summary"))
    $logger.log_results("Bug#577-Issue1-Apply Misc Fees/penalty","Enter a Misc fees or penalty","NA","passed")
    rescue Test::Unit::AssertionFailedError=>e
    $logger.log_results("Bug#577-Issue1-Apply Misc Fees/penalty","Enter a Misc fees or penalty","not working","failed")
    rescue =>excp
    quit_on_error(excp)
  end #end function  apply_miscfees
 
 #A small function which will search the client/group with the customer number provided.Added by Dilip on 1/10/2006
 def search_client(custnum)
    $ie.link(:text,"Clients & Accounts").click
    $ie.text_field(:name,"searchString").set(custnum)
    $ie.button(:value,"Search").click
    $ie.button(:value,"Search").click
     
  end #end of search_client method
   
    # function which will get all periodic fee and customer for whom no periodic fees has been appl
     def add_periodicFee()
    begin
      
      #To find all customers for whom no fees has been applied.
      dbquery("select a.account_id,c.customer_id,c.global_cust_num,c.display_name from account a,customer c ,account_fees d where a.customer_id=c.customer_id and a.account_type_id=3 and a.account_id not in (select account_id from account_fees where fee_status is null or fee_status=1) and c.customer_level_id=1 and c.status_id=3 group by a.account_id")
      newmemberCustomerNum=dbresult[2]
      display_name=dbresult[3]
      customerid=dbresult[1]
      #To get all periodic  fees
      dbquery("select  a.fee_id,a.fee_name,c.recurrence_id from fees a,fee_frequency b,recurrence_detail c where a.fee_id=b.fee_id and (b.frequency_meeting_id=c.meeting_id or b.frequency_meeting_id is null )and c.recurrence_id=(select recurrence_id from recurrence_detail a ,customer_meeting cm where a.meeting_id=cm.meeting_id and customer_id = "+customerid+") and a.fee_id not in (select fee_id from feelevel) and a.category_id in (1,2) and status=1 group by a.fee_id")
      periodicfeeid=dbresult[0]
      search_client(newmemberCustomerNum) 
      $ie.link(:text,display_name+": ID "+newmemberCustomerNum).click
      $ie.link(:text,@@view_details).click
      $ie.link(:text,@@member_applycharges2).click
      $ie.select_list(:name,"chargeType").select_value(periodicfeeid)
      $ie.button(:value,"Submit").click
      assert($ie.contains_text(@@member_applycharges2))
      $logger.log_results("Apply Charges","Should work","Working","Passed")
      click_removeFee
    rescue Test::Unit::AssertionFailedError=>e
      $logger.log_results("Apply Charges","NA","NA","failed")
      rescue =>excp
      quit_on_error(excp)
      
    end
  end  #End of add periodic fee
  
   def count_records(query)
    dbquery(query)
    count=dbresult[0]
    return count.to_i
  end
  
  def click_Applycharges_View_all_account_activity
  
      $ie.link(:text,@@view_details).click
      $ie.link(:text,@@view_all_account_activity).click
      check_Applypayment_view_all_account_activity
      $ie.link(:text,@@member_applycharges1).click
      begin
      assert($ie.contains_text(@@member_applycharges1))
        $logger.log_results("Bug#592-Apply Charges from View all account activity","Should work","Working","Passed")
      rescue Test::Unit::AssertionFailedError=>e
        $logger.log_results("Bug#592-Apply Charges from View all account activity","Click on apply charges from account activity page","NA","failed")
      rescue =>excp
      quit_on_error(excp)
      end
    
    check_blueband_links
    
  end
  
  def check_Applypayment_view_all_account_activity
    assert($ie.contains_text("Apply payment"))
         $logger.log_results("Bug#593-Apply payment link from View all account activity","Should be present","Present","Passed")
    rescue Test::Unit::AssertionFailedError=>e
         $logger.log_results("Bug#593-Apply payment link from View all account activity","Should be present","not present","failed")
    rescue=>excp
    quit_on_error(excp)     
  end
  
  #added by Dilip as  bug#728
  def check_Group_Performance_Metrics()
    dbquery("select customer_id,display_name,global_cust_num from customer where customer_level_id=2 and status_id=9 and branch_id=" + @@office_id)
    globalcustnum=dbresult[2]
    display_name=dbresult[1]
    customerid=dbresult[0]
    noofactivemembers=count_records("select count(global_cust_num) from customer where customer_level_id=1 and parent_customer_id="+customerid+" and status_id=3")
    search_client(globalcustnum)
    $ie.link(:text,display_name.strip()+": ID "+globalcustnum).click
    table_obj=$ie.table(:index,23) 
    stractivemembers=@@active_members_forGroup+": "+noofactivemembers.to_s
    assert(stractivemembers==table_obj[3][1].text.strip())
    $logger.log_results("Bug#727-Group Performance Metrics","Should display no of active members","displayed","Passed")
    rescue Test::Unit::AssertionFailedError=>e
    $logger.log_results("Bug#727-Group Performance Metrics","Should display no of active members","not displayed","failed")
    rescue=>excp
    quit_on_error(excp)     
  end  #end of function Group_Performance_Metrics

  end # end of class


class ClientTest
  clientobject=ClientCreateEdit.new
  #centerobject=CenterCreateEdit.new
  clientobject.client_login
  clientobject.database_connection
  clientobject.propertis_load
  clientobject.get_labels_from_db
  clientobject.read_values_from_hash
  
  #Checks for the create new client link, check for the page select group and click cancel from the group select page
  
  clientobject.check_createnewclient_link
  clientobject.select_grouppage_check
  clientobject.click_cancel_from_group_select
  clientobject.no_groups_while_search
 clientobject.check_next_link_in_search_group_page
  clientobject.check_previous_link_in_search_group_page
  clientobject.select_group
  clientobject.check_all_mandatory_fields_for_client
  clientobject.check_all_mandatory_when_salutation_selected
  clientobject.check_all_mandatory_when_salutation_fname_entered()
  clientobject.check_all_mandatory_when_salutation_fname_lname_dob_entered
  clientobject.check_all_mandatory_when_salutation_fname_lname_dob_gender_entered
  clientobject.check_all_mandatory_when_salutation_fname_lname_dob_gender_SpouseFatherType_entered
  clientobject.check_mandatory_when_SpouseorFatherLastName_AdditionalInformation_not_entered
  clientobject.check_mandatory_when_AdditionalInformation_not_entered
  
  #Opens the Fist sheet in Testdata.xls file to create client with all mandatory data
  
 filename=File.expand_path(File.dirname($PROGRAM_NAME))+"/data/testdata.xls"
  clientobject.open(filename,1)
  rowid=-1
  
  #  creating a client with different sets of mandatory data it reads the data from the opened .xls file
  # and put send the values to create client test cases
  
  while(rowid<$maxrow*$maxcol-1)
    clientobject.read_client_values(rowid,1)
    clientobject.create_client_with_all_mandatory_data(clientobject.Salutation,clientobject.Fname,clientobject.Lname,clientobject.Date,clientobject.Month,\
    clientobject.Year,clientobject.Gender,clientobject.PovertyStatus,clientobject.Religion,clientobject.Sorftype,clientobject.Sorffname,\
    clientobject.Sorflname,clientobject.Custom)
    
    clientobject.check_create_client_mfi_mandatory()
    clientobject.create_client_enter_mfidata(clientobject.Salutation,clientobject.Fname,clientobject.Lname,clientobject.Date,clientobject.Month,\
    clientobject.Year,clientobject.Gender,clientobject.Religion,clientobject.Sorftype,clientobject.Sorffname,\
    clientobject.Sorflname,clientobject.Custom)
    clientobject.submit_data(clientobject.Statusname) 
    clientobject.check_client_charges_label()
    clientobject.db_check()
    #Checking for the View Summarised historical data link exist
    #Checking for the View Summarised historical data link functionality
    clientobject.check_view_summarized_historical_Data_link_exist()
    clientobject.check_view_summarized_historical_Data_link_functionality()    
    
    rowid+=$maxcol
  end    
  
  #Opening the second sheet in the testdata.xls file
  
  clientobject.open(filename,2)
  rowid=-1
  
  #Creating and editing Client with different sets of mandatory and optional data.
  #data comes from the second sheet of testdata.xls
  
  while(rowid<$maxrow*$maxcol-1)
    clientobject.read_client_values(rowid,2)
    clientobject.select_group()
    clientobject.client_create_with_all_data(clientobject.Salutation,clientobject.Fname,clientobject.Mname,clientobject.Sname,clientobject.Lname,clientobject.Govtid,\
                                             clientobject.Date,clientobject.Month,clientobject.Year,clientobject.Gender,clientobject.PovertyStatus,clientobject.Mstatus,clientobject.Noofchildren,\
                                             clientobject.Religion,clientobject.Education,clientobject.Sorftype,clientobject.Sorffname,clientobject.Sorfmname,\
                                             clientobject.Sorfsname,clientobject.Sorflname,clientobject.Address1,clientobject.Address2,clientobject.Address3,clientobject.City,\
                                             clientobject.State,clientobject.Country,clientobject.Pcode,clientobject.Phone,clientobject.Custom)                                               
    clientobject.click_continue() 
    clientobject.check_create_client_mfi_mandatory
    clientobject.client_create_enter_all_data_mfi(clientobject.Externalid,clientobject.Tdate,clientobject.Tmonth,clientobject.Tyear)
    clientobject.click_preview()
    clientobject.edit_personal_information_from_review(clientobject.Salutation,clientobject.Fname,clientobject.Mname,clientobject.Sname,clientobject.Lname,clientobject.Govtid,\
                                                       clientobject.Date,clientobject.Month,clientobject.Year,clientobject.Gender,clientobject.PovertyStatus,clientobject.Mstatus,clientobject.Noofchildren,\
                                                       clientobject.Religion,clientobject.Education,clientobject.Sorftype,clientobject.Sorffname,clientobject.Sorfmname,\
                                                       clientobject.Sorfsname,clientobject.Sorflname,clientobject.Address1,clientobject.Address2,clientobject.Address3,clientobject.City,\
                                                       clientobject.State,clientobject.Country,clientobject.Pcode,clientobject.Phone,clientobject.Custom)
    clientobject.edit_mfi_information_from_review(clientobject.Externalid,clientobject.Tdate,clientobject.Tmonth,clientobject.Tyear)
    #Submits the client data with given status, 
    #change the status and checks the entity in View change log page
    #checks for different labels and functionality of links 
    
    clientobject.submit_data(clientobject.Statusname) 
    clientobject.check_client_charges_label()
    clientobject.db_check()
    #Searching the client from the Clients&Accounts page and editing the personnnel and MFI informations from client details page
    #Editing the group membership from client details page
    #checking for the view all closed account link functionality
    #PovertyStatus
    clientobject.search_client_from_clients_accounts_page()
    clientobject.check_edit_client_personalinformation_link_from_details_page
    clientobject.edit_client_personnel_enter_data(clientobject.Salutation,clientobject.Fname,clientobject.Mname,clientobject.Sname,clientobject.Lname,clientobject.Govtid,\
                                                  clientobject.Date,clientobject.Month,clientobject.Year,clientobject.Gender,clientobject.PovertyStatus,clientobject.Mstatus,clientobject.Noofchildren,\
                                                  clientobject.Religion,clientobject.Education,clientobject.Sorftype,clientobject.Sorffname,clientobject.Sorfmname,\
                                                  clientobject.Sorfsname,clientobject.Sorflname,clientobject.Address1,clientobject.Address2,clientobject.Address3,clientobject.City,\
                                                  clientobject.State,clientobject.Country,clientobject.Pcode,clientobject.Phone,clientobject.Custom)
    clientobject.check_edit_client_mfi_data_link_from_details_page
    clientobject.edit_client_mfi_enter_data(clientobject.Externalid)
    #Checking for edit group membership link
    #checking for edit group membership link functionality
    #editing the group membership  
    clientobject.check_edit_group_membership_link()
    clientobject.click_edit_group_membership_link()   
    clientobject.edit_group_membership() 
    #Checking for View closed account link functinality
    clientobject.check_view_all_closed_accounts_link
    clientobject.click_view_all_closed_accounts_link
    #Clicking on the links and check the page whether it is redirecting to proper page
    #Adding a note
    clientobject.check_add_notes_link
    clientobject.click_add_notes_link
    clientobject.check_mandatory_in_add_notes_page
    clientobject.enter_more_data_in_notes_field(clientobject.Notes)
    #Checking for the Add notes and see all notes links    
    clientobject.enter_data_in_add_note
    clientobject.check_for_see_all_notes_link
    clientobject.click_see_all_notes_link        
    rowid+=$maxcol
  end 
  
 # Opening the third sheet in the testdata.xls file to create client outside the group
  
  clientobject.open(filename,3)
  rowid=-1
  
  #Creating and editing of client when client is out side the group with different sets of mandatory and optional data
  #creating meeting to the client
  #Removing the admin fee
  #clientobject.check_all_mandatory_fields_for_client()
  #   clientobject.check_createnewclient_link()
  while(rowid<$maxrow*$maxcol-1)
    clientobject.read_client_values(rowid,3)
    clientobject.check_create_client_out_of_group_link 
    clientobject.click_create_client_out_of_group_link 
    #clientobject.create_client_out_of_group(clientobject.Salutation,clientobject.Fname,clientobject.Mname,clientobject.Sname,clientobject.Lname,clientobject.Govtid,clientobject.Date,\
     #                                       clientobject.Month,clientobject.Year,clientobject.Gender,clientobject.Mstatus,clientobject.Noofchildren,clientobject.Religion,\
      #                                      clientobject.Education,clientobject.Sorftype,clientobject.Sorffname,clientobject.Sorfmname,clientobject.Sorfsname,clientobject.Sorflname,\
       #                                     clientobject.Address1,clientobject.Address2,clientobject.Address3,clientobject.City,clientobject.State,clientobject.Country,clientobject.Pcode,\
        #                                    clientobject.Phone,clientobject.Custom,clientobject.Externalid,clientobject.Tdate,clientobject.Tmonth,clientobject.Tyear)
                                            
    clientobject.create_client_out_of_group(clientobject.Salutation,clientobject.Fname,clientobject.Mname,clientobject.Sname,clientobject.Lname,clientobject.Govtid,clientobject.Date,\
                                            clientobject.Month,clientobject.Year,clientobject.Gender,clientobject.PovertyStatus,clientobject.Mstatus,clientobject.Noofchildren,clientobject.Religion,\
                                            clientobject.Education,clientobject.Sorftype,clientobject.Sorffname,clientobject.Sorfmname,clientobject.Sorfsname,clientobject.Sorflname,\
                                            clientobject.Address1,clientobject.Address2,clientobject.Address3,clientobject.City,clientobject.State,clientobject.Country,clientobject.Pcode,\
                                            clientobject.Phone,clientobject.Custom,clientobject.Externalid,clientobject.Tdate,clientobject.Tmonth,clientobject.Tyear)                                            
    clientobject.select_loan_officer 
    clientobject.create_meeting(clientobject.Frequncymeeting,clientobject.Monthtype,clientobject.Reccurweek,clientobject.Weekweekday,clientobject.Monthday,clientobject.Monthmonth,\
                                clientobject.Monthrank,clientobject.Monthweek,clientobject.Monthmonthrank,clientobject.Meetingplace)                                           
    clientobject.click_preview 
    clientobject.client_create_remove_admin_fee_from_review_page()
    clientobject.submit_data(clientobject.Statusname)
    
    #Check for edit branch membership link
    #check for edit branch membership working
    #Editing the branch membership   
    clientobject.check_edit_branch_member_link_exist
    clientobject.check_edit_branch_member_link_functionality
    clientobject.edit_branch_membership                              
    rowid+=$maxcol
  end    
  
  for i in ["-1","-2"] # selecting Misc Fees and Misc Penalty
  # for i in ["-1"]
        clientobject.apply_miscfees(i)
   end
   
   clientobject.add_periodicFee
   clientobject.check_applyfee
     #added by Dilip as part of Bug#592
   clientobject.click_Applycharges_View_all_account_activity()
   #added by Dilip as part of Bug#728
   clientobject.check_Group_Performance_Metrics()
   
  clientobject.mifos_logout
end