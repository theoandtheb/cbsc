class ApplicationController < ActionController::API

	def got_it
		puts params
		@full_time = Time.now
		@date = @full_time.strftime("%Y/%m/%d")
		@time = @full_time.strftime("%H:%M")
		Complaint.create(
		{
			"frmstationasincwords"=>params[:stationName],
			"frmprogram"=>params[:programmeName],
			"frmrawdatebrcst"=>params[:dateOfProgram],
			"frmrawtimebrcst"=>params[:timeOfProgram],
			"frmconcern"=>params[:specificConcern],
			"frmaddress"=>params[:yourAddress],
			"frmcity"=>params[:yourCity],
			"frmprovince"=>params[:yourProvince],
			"frmpostalcode"=>params[:yourPostalCode],
			"frmfirstname"=>params[:firstName],
			"frmlastname"=>params[:lastName],
			"frmsalutation"=>params[:yourTitle],
			"frmemail"=>params[:yourEmail],
			"frmisprocessed"=>"No",
			"frmrawdatesubmit" => @date,
			"frmrawtimesubmit" => @time,
			"global cbsc info::logo icon"=>"/fmi/xml/cnt/cbsc_logo_Well%20trimmed.png?-db=Main%20Files%20Database&-lay=webform&-field=Global CBSC Info::Logo Icon(1)"
		}
	)
	end
end