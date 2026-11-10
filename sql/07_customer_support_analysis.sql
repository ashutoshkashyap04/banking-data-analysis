-- Overall support performance

SELECT
    COUNT(*) AS total_tickets,

    COUNT(*) FILTER (
        WHERE status = 'Resolved'
    ) AS resolved_tickets,

    COUNT(*) FILTER (
        WHERE status = 'Open'
    ) AS open_tickets,

	COUNT(*) FILTER (
        WHERE status = 'Escalated'
    ) AS escalated_tickets,

    ROUND(
        COUNT(*) FILTER (
            WHERE status = 'Resolved'
        ) * 100.0 / NULLIF(COUNT(*), 0),
        2
    ) AS resolution_percentage,

    ROUND(AVG(satisfaction_score), 2) AS avg_satisfaction_score

FROM support_tickets;

-- Issue type analysis

SELECT
    issue_type,
    COUNT(*) AS total_tickets,
    COUNT(*) FILTER (
        WHERE status = 'Resolved'
    ) AS resolved_tickets,
	
    COUNT(*) FILTER (
        WHERE status = 'Open'
    ) AS open_tickets,

	COUNT(*) FILTER (
		WHERE status = 'Escalated'
	) AS escalated_tickets,
	
    ROUND(AVG(satisfaction_score), 2) AS avg_satisfaction
FROM support_tickets
GROUP BY issue_type
ORDER BY total_tickets DESC;

-- Ticket status analysis

SELECT
    status,
    COUNT(*) AS ticket_count,
    ROUND(
        COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (),
        2
    ) AS ticket_percentage
FROM support_tickets
GROUP BY status
ORDER BY ticket_count DESC;


-- Ticket resolution time analysis

SELECT 
	ROUND(
			AVG(date_resolved - date_opened),   -- EPOCH converts a time interval into total seconds
			2
	)AS avg_resolution_days,

	ROUND(
			MIN(date_resolved - date_opened),
			2
	)AS min_resolution_days,

	ROUND(
			MAX(date_resolved - date_opened),
			2
	)AS max_resolution_days

FROM support_tickets;

-- Customer satisfaction analysis

SELECT
    satisfaction_score,
    COUNT(*) AS ticket_count
FROM support_tickets
GROUP BY satisfaction_score
ORDER BY satisfaction_score;


-- Satisfaction by issue type

SELECT
    issue_type,
    ROUND(AVG(satisfaction_score), 2) AS avg_satisfaction,
    COUNT(*) AS rated_tickets
FROM support_tickets
GROUP BY issue_type
ORDER BY avg_satisfaction DESC;