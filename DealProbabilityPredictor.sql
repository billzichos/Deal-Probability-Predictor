select
 GETDATE() "Snapshot DateTime",
 d.RLM_DealNumber "Deal Number",
 isnull(d.RLM_Agreement, 'UNKNOWN') "Agreement",
 d.rlm_dealtypeidName "Deal Type",
 isnull(d.arg_PrimaryLeasingAgentName, 'UNKNOWN') "Primary Leasing Agent",
 isnull(d.rlm_scenariobuildingidName, 'UNKNOWN') "Building",
 isnull(convert(nvarchar, d.rlm_totalrentablearea), 'UNKNOWN') "Deal Square Footage",
 isnull(convert(nvarchar, d.RLM_LeaseTermMonths), 'UNKNOWN') "Lease Term (Months)",
 datediff(d, d.CreatedOn, GETDATE()) "# Days Since Creation",
 isnull(convert(nvarchar,d.RLM_CurrentWorkflowStageSeq), 'Not Started') "Current Phase in the Sales (Leasing) Process",
 case isnull(d.RLM_CurrentWorkflowStageSeq, -1)
  when -1 then 'Not Started'
  when 0 then 'Stage 0'
  else convert(nvarchar, datediff(d, d.RLM_CurrentWorkflowStartDt, getdate())) end "# of Days in Current Phase",
isnull(case 
	when (case d.rlm_nerbudget_rate_Base when 0 then 0 else (d.rlm_ner_rate_Base - d.rlm_nerbudget_rate_Base)/d.rlm_nerbudget_rate_Base end) < -1.00 then 'Worse than -100% under budget'
	when (case d.rlm_nerbudget_rate_Base when 0 then 0 else (d.rlm_ner_rate_Base - d.rlm_nerbudget_rate_Base)/d.rlm_nerbudget_rate_Base end) between -1.00 and -.95 then 'Between -100 and -95% under budget'
	when (case d.rlm_nerbudget_rate_Base when 0 then 0 else (d.rlm_ner_rate_Base - d.rlm_nerbudget_rate_Base)/d.rlm_nerbudget_rate_Base end) between -.95 and -.90 then 'Between -95 and -90% under budget'
	when (case d.rlm_nerbudget_rate_Base when 0 then 0 else (d.rlm_ner_rate_Base - d.rlm_nerbudget_rate_Base)/d.rlm_nerbudget_rate_Base end) between -.90 and -.85 then 'Between -90 and -85% under budget'
	when (case d.rlm_nerbudget_rate_Base when 0 then 0 else (d.rlm_ner_rate_Base - d.rlm_nerbudget_rate_Base)/d.rlm_nerbudget_rate_Base end) between -.85 and -.80 then 'Between -85 and -80% under budget'
	when (case d.rlm_nerbudget_rate_Base when 0 then 0 else (d.rlm_ner_rate_Base - d.rlm_nerbudget_rate_Base)/d.rlm_nerbudget_rate_Base end) between -.80 and -.75 then 'Between -80 and -75% under budget'
	when (case d.rlm_nerbudget_rate_Base when 0 then 0 else (d.rlm_ner_rate_Base - d.rlm_nerbudget_rate_Base)/d.rlm_nerbudget_rate_Base end) between -.75 and -.70 then 'Between -75 and -70% under budget'
	when (case d.rlm_nerbudget_rate_Base when 0 then 0 else (d.rlm_ner_rate_Base - d.rlm_nerbudget_rate_Base)/d.rlm_nerbudget_rate_Base end) between -.70 and -.65 then 'Between -70 and -65% under budget'
	when (case d.rlm_nerbudget_rate_Base when 0 then 0 else (d.rlm_ner_rate_Base - d.rlm_nerbudget_rate_Base)/d.rlm_nerbudget_rate_Base end) between -.65 and -.60 then 'Between -65 and -60% under budget'
	when (case d.rlm_nerbudget_rate_Base when 0 then 0 else (d.rlm_ner_rate_Base - d.rlm_nerbudget_rate_Base)/d.rlm_nerbudget_rate_Base end) between -.60 and -.55 then 'Between -60 and -55% under budget'
	when (case d.rlm_nerbudget_rate_Base when 0 then 0 else (d.rlm_ner_rate_Base - d.rlm_nerbudget_rate_Base)/d.rlm_nerbudget_rate_Base end) between -.55 and -.50 then 'Between -55 and -50% under budget'
	when (case d.rlm_nerbudget_rate_Base when 0 then 0 else (d.rlm_ner_rate_Base - d.rlm_nerbudget_rate_Base)/d.rlm_nerbudget_rate_Base end) between -.50 and -.45 then 'Between -50 and -45% under budget'
	when (case d.rlm_nerbudget_rate_Base when 0 then 0 else (d.rlm_ner_rate_Base - d.rlm_nerbudget_rate_Base)/d.rlm_nerbudget_rate_Base end) between -.45 and -.40 then 'Between -45 and -40% under budget'
	when (case d.rlm_nerbudget_rate_Base when 0 then 0 else (d.rlm_ner_rate_Base - d.rlm_nerbudget_rate_Base)/d.rlm_nerbudget_rate_Base end) between -.40 and -.35 then 'Between -40 and -35% under budget'
	when (case d.rlm_nerbudget_rate_Base when 0 then 0 else (d.rlm_ner_rate_Base - d.rlm_nerbudget_rate_Base)/d.rlm_nerbudget_rate_Base end) between -.35 and -.30 then 'Between -35 and -30% under budget'
	when (case d.rlm_nerbudget_rate_Base when 0 then 0 else (d.rlm_ner_rate_Base - d.rlm_nerbudget_rate_Base)/d.rlm_nerbudget_rate_Base end) between -.30 and -.25 then 'Between -30 and -25% under budget'
	when (case d.rlm_nerbudget_rate_Base when 0 then 0 else (d.rlm_ner_rate_Base - d.rlm_nerbudget_rate_Base)/d.rlm_nerbudget_rate_Base end) between -.25 and -.20 then 'Between -25 and -20% under budget'
	when (case d.rlm_nerbudget_rate_Base when 0 then 0 else (d.rlm_ner_rate_Base - d.rlm_nerbudget_rate_Base)/d.rlm_nerbudget_rate_Base end) between -.20 and -.15 then 'Between -20 and -15% under budget'
	when (case d.rlm_nerbudget_rate_Base when 0 then 0 else (d.rlm_ner_rate_Base - d.rlm_nerbudget_rate_Base)/d.rlm_nerbudget_rate_Base end) between -.15 and -.10 then 'Between -15 and -10% under budget'
	when (case d.rlm_nerbudget_rate_Base when 0 then 0 else (d.rlm_ner_rate_Base - d.rlm_nerbudget_rate_Base)/d.rlm_nerbudget_rate_Base end) between -.10 and -.05 then 'Between -10 and -5% under budget'
	when (case d.rlm_nerbudget_rate_Base when 0 then 0 else (d.rlm_ner_rate_Base - d.rlm_nerbudget_rate_Base)/d.rlm_nerbudget_rate_Base end) between -.05 and 0 then 'Between -5 and 0% under budget'
	when (case d.rlm_nerbudget_rate_Base when 0 then 0 else (d.rlm_ner_rate_Base - d.rlm_nerbudget_rate_Base)/d.rlm_nerbudget_rate_Base end) between 0 and .05 then 'Between 0 and 5% above budget'
	when (case d.rlm_nerbudget_rate_Base when 0 then 0 else (d.rlm_ner_rate_Base - d.rlm_nerbudget_rate_Base)/d.rlm_nerbudget_rate_Base end) between .05 and .10 then 'Between 5 and 10% above budget'
	when (case d.rlm_nerbudget_rate_Base when 0 then 0 else (d.rlm_ner_rate_Base - d.rlm_nerbudget_rate_Base)/d.rlm_nerbudget_rate_Base end) between .10 and .15 then 'Between 10 and 15% above budget'
	when (case d.rlm_nerbudget_rate_Base when 0 then 0 else (d.rlm_ner_rate_Base - d.rlm_nerbudget_rate_Base)/d.rlm_nerbudget_rate_Base end) between .15 and .20 then 'Between 15 and 20% above budget'
	when (case d.rlm_nerbudget_rate_Base when 0 then 0 else (d.rlm_ner_rate_Base - d.rlm_nerbudget_rate_Base)/d.rlm_nerbudget_rate_Base end) between .20 and .25 then 'Between 20 and 25% above budget'
	when (case d.rlm_nerbudget_rate_Base when 0 then 0 else (d.rlm_ner_rate_Base - d.rlm_nerbudget_rate_Base)/d.rlm_nerbudget_rate_Base end) between .25 and .30 then 'Between 25 and 30% above budget'
	when (case d.rlm_nerbudget_rate_Base when 0 then 0 else (d.rlm_ner_rate_Base - d.rlm_nerbudget_rate_Base)/d.rlm_nerbudget_rate_Base end) between .30 and .35 then 'Between 30 and 35% above budget'
	when (case d.rlm_nerbudget_rate_Base when 0 then 0 else (d.rlm_ner_rate_Base - d.rlm_nerbudget_rate_Base)/d.rlm_nerbudget_rate_Base end) between .35 and .40 then 'Between 35 and 40% above budget'
	when (case d.rlm_nerbudget_rate_Base when 0 then 0 else (d.rlm_ner_rate_Base - d.rlm_nerbudget_rate_Base)/d.rlm_nerbudget_rate_Base end) between .40 and .45 then 'Between 40 and 45% above budget'
	when (case d.rlm_nerbudget_rate_Base when 0 then 0 else (d.rlm_ner_rate_Base - d.rlm_nerbudget_rate_Base)/d.rlm_nerbudget_rate_Base end) between .45 and .50 then 'Between 45 and 50% above budget'
	when (case d.rlm_nerbudget_rate_Base when 0 then 0 else (d.rlm_ner_rate_Base - d.rlm_nerbudget_rate_Base)/d.rlm_nerbudget_rate_Base end) between .50 and .55 then 'Between 50 and 55% above budget'
	when (case d.rlm_nerbudget_rate_Base when 0 then 0 else (d.rlm_ner_rate_Base - d.rlm_nerbudget_rate_Base)/d.rlm_nerbudget_rate_Base end) between .55 and .60 then 'Between 55 and 60% above budget'
	when (case d.rlm_nerbudget_rate_Base when 0 then 0 else (d.rlm_ner_rate_Base - d.rlm_nerbudget_rate_Base)/d.rlm_nerbudget_rate_Base end) between .60 and .65 then 'Between 60 and 65% above budget'
	when (case d.rlm_nerbudget_rate_Base when 0 then 0 else (d.rlm_ner_rate_Base - d.rlm_nerbudget_rate_Base)/d.rlm_nerbudget_rate_Base end) between .65 and .70 then 'Between 65 and 70% above budget'
	when (case d.rlm_nerbudget_rate_Base when 0 then 0 else (d.rlm_ner_rate_Base - d.rlm_nerbudget_rate_Base)/d.rlm_nerbudget_rate_Base end) between .70 and .75 then 'Between 70 and 75% above budget'
	when (case d.rlm_nerbudget_rate_Base when 0 then 0 else (d.rlm_ner_rate_Base - d.rlm_nerbudget_rate_Base)/d.rlm_nerbudget_rate_Base end) between .75 and .80 then 'Between 75 and 80% above budget'
	when (case d.rlm_nerbudget_rate_Base when 0 then 0 else (d.rlm_ner_rate_Base - d.rlm_nerbudget_rate_Base)/d.rlm_nerbudget_rate_Base end) between .80 and .85 then 'Between 80 and 85% above budget'
	when (case d.rlm_nerbudget_rate_Base when 0 then 0 else (d.rlm_ner_rate_Base - d.rlm_nerbudget_rate_Base)/d.rlm_nerbudget_rate_Base end) between .85 and .90 then 'Between 85 and 90% above budget'
	when (case d.rlm_nerbudget_rate_Base when 0 then 0 else (d.rlm_ner_rate_Base - d.rlm_nerbudget_rate_Base)/d.rlm_nerbudget_rate_Base end) between .90 and .95 then 'Between 90 and 95% above budget'
	when (case d.rlm_nerbudget_rate_Base when 0 then 0 else (d.rlm_ner_rate_Base - d.rlm_nerbudget_rate_Base)/d.rlm_nerbudget_rate_Base end) between .95 and 1.00 then 'Between 95 and 100% above budget'
	when (case d.rlm_nerbudget_rate_Base when 0 then 0 else (d.rlm_ner_rate_Base - d.rlm_nerbudget_rate_Base)/d.rlm_nerbudget_rate_Base end) > 1.00 then 'Better than 100% above budget'
end, 'UNKNOWN') "Deal NER % Difference To Budget NER",
 isnull(b.rlm_stateprovinceidName, 'UNKNOWN') "State",
 isnull(b.RLM_ZIPPostalCode, 'UNKNOWN') "ZIP",
 isnull(b.rlm_marketidName, 'UNKNOWN') "Submarket",
 isnull(b.rlm_propertytypeidName, 'UNKNOWN') "Building Type",
 d.AccountIdName "Customer",
 case a.copt_IsGovernmentFlag
  when 0 then 'Not Government'
  when 1 then 'Government' end "Government Indicator"
from Opportunity d
left outer join RLM_Building b on (b.rlm_buildingid = d.rlm_scenariobuildingid)
left outer join Account a on (a.AccountId = d.AccountId)
where d.StateCode = 0
order by d.RLM_DealNumber