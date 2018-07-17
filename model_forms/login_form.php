<div class="modal fade" id="loginForm">
  <div class="modal-dialog modal-dialog-centered modal-sm">
    <div class="modal-content">

      <div class="modal-header">
        <h5 class="modal-title">Member Login</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>

      <div class="modal-body">
        <div class="text-center">
          <img src="images/user.png" class="img-fluid w-50 my-3" />
        </div>

        <form onsubmit = "onLoginButtonClicked(); return false;">
          <div class="form-group">
            <input type="email" class="form-control" id="email" placeholder="username@website.com" required/>
          </div>
          <div class="form-group">
            <input type="password" class="form-control" id="password" placeholder="Password" required/>
          </div>

          <div id="wrong_login" class=" text-danger text-justify">
              <span class="fas fa-exclamation-triangle ml-3 mr-1"></span>
              <span class="text">Invalid username or password</span>
          </div>

          <hr />

          <div class="text-right m-3">
            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
            <button type="submit" class="btn btn-primary" id="login">Login</button>
          </div>

        </form>
      </div>
    </div>
  </div>
</div>
