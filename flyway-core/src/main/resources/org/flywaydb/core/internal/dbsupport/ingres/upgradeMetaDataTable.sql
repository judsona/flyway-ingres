--
-- Copyright 2010-2016 Boxfuse GmbH
--
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
--
--         http://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.
--

DROP INDEX "${schema}"."${table}_vr_idx";
DROP INDEX "${schema}"."${table}_ir_idx";
DROP INDEX "${schema}"."${table}_s_idx";

ALTER TABLE "${schema}"."${table}" DROP COLUMN "version_rank" RESTRICT;
ALTER TABLE "${schema}"."${table}" ALTER COLUMN "version" VARCHAR(50) WITH NULL;
ALTER TABLE "${schema}"."${table}" DROP COLUMN "success" RESTRICT;
ALTER TABLE "${schema}"."${table}" ADD COLUMN "success" BOOLEAN NOT NULL WITH DEFAULT;

UPDATE "${schema}"."${table}" SET "success" = TRUE;
UPDATE "${schema}"."${table}" SET "type"='BASELINE' WHERE "type"='INIT';

CREATE INDEX "${schema}"."${table}_ir_idx" ON "${schema}"."${table}" ("installed_rank");
CREATE INDEX "${schema}"."${table}_s_idx" ON "${schema}"."${table}" ("success");