<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html-el" prefix="html-el"%>
<%@ taglib uri="/tags/mifos-html" prefix="mifos"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/sessionaccess" prefix="session"%>
<tiles:insert definition=".create">
	<tiles:put name="body" type="string">
	<script src="pages/application/surveys/js/questions.js" type="text/javascript"></script>
		<html-el:form action="/surveysAction.do?method=preview" focus="name">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td height="450" align="left" valign="top" bgcolor="#FFFFFF">

					<table width="90%" border="0" align="center" cellpadding="0"
						cellspacing="0">
						<tr>
							<td align="center" class="heading">&nbsp;</td>
						</tr>
					</table>

					<table width="90%" border="0" align="center" cellpadding="0"
						cellspacing="0">
						<tr>
							<td class="bluetablehead">
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td width="27%">
									<table border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td><img src="pages/framework/images/timeline/bigarrow.gif"
												width="17" height="17"></td>
											<td class="timelineboldorange"><mifos:mifoslabel
												name="Surveys.surveyInformation" bundle="SurveysUIResources" /></td>
										</tr>
									</table>
									</td>
									<td width="73%" align="right">
									<table border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td><img
												src="pages/framework/images/timeline/orangearrow.gif"
												width="17" height="17"></td>
											<td class="timelineboldorangelight"><mifos:mifoslabel
												name="Surveys.review" bundle="SurveysUIResources" /></td>
										</tr>
									</table>
									</td>
								</tr>
							</table>
							</td>
						</tr>
					</table>
					<table width="90%" border="0" align="center" cellpadding="0"
						cellspacing="0" class="bluetableborder">
						<tr>
							<td align="left" valign="top" class="paddingleftCreates">
							<table width="93%" border="0" cellpadding="3" cellspacing="0">
								<tr>
									<td class="headingorange"><span class="heading"> <mifos:mifoslabel
										name="Surveys.definenewsurvey" bundle="SurveysUIResources" /> - </span> <mifos:mifoslabel
										name="Surveys.enter_survey" bundle="SurveysUIResources" /></td>
								</tr>
								<tr><td><font class="fontnormalRedBold"> <html-el:errors bundle="SurveysUIResources" /> </font>
</td></tr>
								<tr>
									<td class="fontnormal"><mifos:mifoslabel
										name="Surveys.create_page_instructions" bundle="SurveysUIResources" />
									<br>
									<mifos:mifoslabel name="funds.mandatoryinstructions"
										mandatory="yes" bundle="fundUIResources" /></td>
								</tr>
							</table>
							<br>
							<table width="93%" border="0" cellpadding="3" cellspacing="0">
								<tr>
									<td colspan="2" class="fontnormalbold"><mifos:mifoslabel
										name="Surveys.survey_details" bundle="SurveysUIResources" /> <br>
									<br>
									</td>
								</tr>
								<tr class="fontnormal">
									<td width="27%" align="right"><mifos:mifoslabel
										name="Surveys.survey_name" mandatory="yes"
										bundle="SurveysUIResources" />:</td>
									<td width="73%" valign="top"><mifos:mifosalphanumtext
										property="name" maxlength="100" /></td>
								</tr>
								<tr class="fontnormal">
									<td align="right" valign="top"><mifos:mifoslabel
										name="Surveys.Appliesto" mandatory="yes"
										bundle="SurveysUIResources" />:</td>
									<td valign="top"><mifos:select property="appliesTo"
										style="width:136px;">
										<html-el:option value="customers"><mifos:mifoslabel name="Surveys.customers_type" bundle="SurveysUIResources"/></html-el:option>
										<html-el:option value="accounts"><mifos:mifoslabel name="Surveys.accounts_type" bundle="SurveysUIResources"/></html-el:option>
										<html-el:option value="both"><mifos:mifoslabel name="Surveys.both_type" bundle="SurveysUIResources"/></html-el:option>
									</mifos:select></td>
								</tr>
                                                                <tr class="fontnormal">
                                                                   <td align="right" valign="top"><mifos:mifoslabel name="Surveys.select_questions" bundle="SurveysUIResources"/></td>
<td valign="top">

												<html-el:select size="10" style="width:40em" property="newQuestion">

<c:forEach var="question" items="${sessionScope.questionsList}">
<html-el:option value="${question.questionId}"><c:out value="${question.questionText}"/></html-el:option>
</c:forEach>
                          </html-el:select><td valign="top"><input id="AddButton" type="button" class="insidebuttn" value="Add &gt;&gt;" style="width:65px"  onclick="submitSurveyForm('add_new_question')"/></td>
</td></tr>


							</table>
<br/>
            <table width="98%" border="0" cellpadding="3" cellspacing="0">
              <tr>
                <td class="drawtablehd">Question text</td>
                <td class="drawtablehd">Delete</td>
<c:forEach items="${sessionScope.addedQuestions}" var="question" varStatus="status">
<tr>
<td class="drawtablerow"><c:out value="${question.questionText}" /></td>
<td class="drawtablerow"><input type="button" onclick="submitSurveyForm('delete_new_question&questionNum=${question.questionId}&randomNUm=${sessionScope.randomNUm}&currentFlowKey=${requestScope.currentFlowKey}')" value="Delete" class="buttn"/></td>
</tr>
</c:forEach>
	     </tr>

							<table width="93%" border="0" cellpadding="0" cellspacing="0">
								<tr>
									<td align="center" class="blueline">&nbsp;</td>
								</tr>
							</table>
							<br>
							<table width="93%" border="0" cellpadding="0" cellspacing="0">
								<tr>
									<td align="center"><html-el:submit style="width:65px;"
										property="button" styleClass="buttn">
										<mifos:mifoslabel name="Surveys.button.preview"
											bundle="SurveysUIResources" />
									</html-el:submit>&nbsp; <html-el:button property="calcelButton" style="width:65px;"
										styleClass="cancelbuttn" onclick="window.location='adminAction.do?method=load">
										<mifos:mifoslabel name="Surveys.button.cancel" bundle="SurveysUIResources" />
									</html-el:button></td>
								</tr>
							</table>
							<br>
						</tr>

					</table>
					<br><html-el:hidden property="currentFlowKey" value="${requestScope.currentFlowKey}" />
					</html-el:form> 
					</tiles:put> </tiles:insert>
