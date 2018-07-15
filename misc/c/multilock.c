/* Lock a set of locks, unlocking all and trying again if any other than the
   first fails.  To make this better than busy-waiting, we wait on the lock
   which we failed to acquire (by locking and unlocking it). */
void multilock(lock_t *locks)
{
  while (1)
    {
      int failed_lock = 0;
      lock(locks[0]);
      for (int i = 1; i < ARRAY_SIZE(locks); ++i)
        if ( ! try(locks[i]) )
          {
            failed_lock = i;
            break;
          }
      if (failed_lock != 0)
        {
          unlock(locks[0]);
          for (int i = 1; i < failed_lock; ++i)
            unlock(locks[i]);
          /* Wait for the failed lock. */
          lock(locks[failed_lock]);
          unlock(locks[failed_lock]);
        }
      else
        break;
    }
}
