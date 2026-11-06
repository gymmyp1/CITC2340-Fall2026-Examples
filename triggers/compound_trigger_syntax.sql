CREATE OR REPLACE TRIGGER trigger_name
FOR INSERT OR UPDATE OR DELETE ON table_name
COMPOUND TRIGGER

  -- 1. DECLARATIVE SECTION (Optional)
  -- Variables declared here are global to all timing blocks
  -- and persist for the duration of the DML statement.
  v_global_counter NUMBER := 0;

  -- 2. BEFORE STATEMENT SECTION (Optional)
  BEFORE STATEMENT IS
  BEGIN
    -- Code runs once BEFORE the entire SQL statement begins
    NULL;
  END BEFORE STATEMENT;

  -- 3. BEFORE EACH ROW SECTION (Optional)
  BEFORE EACH ROW IS
  BEGIN
    -- Code runs once for EVERY ROW before it is modified
    -- You can read/write :NEW values and read :OLD values here
    NULL;
  END BEFORE EACH ROW;

  -- 4. AFTER EACH ROW SECTION (Optional)
  AFTER EACH ROW IS
  BEGIN
    -- Code runs once for EVERY ROW after it is modified
    -- You can read :NEW and :OLD values here
    NULL;
  END AFTER EACH ROW;

  -- 5. AFTER STATEMENT SECTION (Optional)
  AFTER STATEMENT IS
  BEGIN
    -- Code runs once AFTER the entire SQL statement completes
    NULL;
  END AFTER STATEMENT;

END trigger_name;
/
