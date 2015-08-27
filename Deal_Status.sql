SELECT RLM_DealNumber "Deal Number"
	,(
		CASE StateCode
			WHEN 0
				THEN 'Open'
			WHEN 1
				THEN 'Won'
			WHEN 2
				THEN 'Lost'
			END
		) "Status"
FROM Opportunity d
ORDER BY RLM_DealNumber