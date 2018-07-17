<div class="modal fade" id="logoutForm">
  <div class="modal-dialog modal-dialog-centered modal-sm">
    <div class="modal-content">

      <div class="modal-header">
        <h5 class="modal-title">Member Logout</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>

      <div class="modal-body">
        <form action = "user_login/logout.php" method = "post" onsubmit="return signOut()">
          <p>Are you sure you want to Sign Out?</p>
          <div class="text-right">
            <button type="button" class="btn btn-secondary" data-dismiss="modal">No</button>
            <button type="submit" class="btn btn-primary">Yes</button>
          </div>
        </form>
      </div>
      
    </div>
  </div>
</div>
