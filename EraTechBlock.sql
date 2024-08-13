-- EraTechBlock
-- Author: gggdo
-- DateCreated: 8/13/2024 11:59:16 AM
--------------------------------------------------------------
-- Add a new column to track if a technology should be blocked
ALTER TABLE Technologies ADD COLUMN IsBlocked INTEGER DEFAULT 0;

-- Initialize all future era technologies as blocked
UPDATE Technologies SET IsBlocked = 1 WHERE EraType > (SELECT EraType FROM Eras WHERE EraType = 'ERA_ANCIENT');
