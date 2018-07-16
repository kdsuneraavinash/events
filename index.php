<?php include("header.php"); ?>

<div class="container" id="home_content">
  <div class="card p-3 content">
    <h2>What is this ?</h2>
    <hr/>
    <div class="row">
      <div class="col-sm" id="welcome_highlight">
        <img id="welcome_img" class="img-fluid rounded my-2 w-100" src="https://picsum.photos/400/300/?25" alt="Welcome Image" />
      </div>
      <div class="col-sm text-justify" id="welcome_text">
        <p>
          Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla rutrum sollicitudin ipsum vitae ornare. Fusce tincidunt rhoncus
          efficitur. Sed tempus arcu eleifend dolor imperdiet eleifend. Mauris ac egestas mi. Nullam rhoncus, massa malesuada
          hendrerit auctor, elit ipsum varius nulla, ut ultricies nisi ligula non lorem. Ut egestas nisl in mauris consectetur
          semper. Praesent at mi libero. Quisque porttitor posuere dui, quis ullamcorper lacus posuere sit amet. Vivamus
          quis metus neque. Ut dignissim aliquam mi a mattis. Duis laoreet dui eu volutpat fringilla. Proin rhoncus scelerisque
          orci scelerisque euismod. Etiam sit amet neque vel nibh faucibus maximus. Vestibulum ac mi in odio aliquet viverra
          non et leo. Sed dolor ligula.
        </p>
        <p>
          et varius ac, pharetra ut mauris. Nunc fermentum tincidunt neque vel blandit. Curabitur vel orci dolor. Mauris at risus eu
          metus egestas efficitur. Duis pulvinar leo sit amet dignissim hendrerit. Class aptent taciti sociosqu ad litora
          torquent per conubia nostra, per inceptos himenaeos. Maecenas dapibus venenatis erat, ut feugiat purus pharetra
          eget. Donec condimentum scelerisque mi, nec pretium libero tincidunt at. Aliquam vitae libero massa. Aliquam dignissim
          ultricies pharetra. Quisque rutrum leo ut ex dapibus, et malesuada leo vehicula. ​
        </p>
      </div>
    </div>

    <hr />
    <h2>Our App</h2>
    <hr />
    <div class="row">
      <div class="col-sm-4 text-justify">
        <p>
          et varius ac, pharetra ut mauris. Nunc fermentum tincidunt neque vel blandit. Curabitur vel orci dolor. Mauris at risus eu
          metus egestas efficitur. Duis pulvinar leo sit amet dignissim hendrerit. Class aptent taciti sociosqu ad litora
          torquent per conubia nostra, per inceptos himenaeos. Maecenas dapibus venenatis erat, ut feugiat purus pharetra
          eget. Donec condimentum scelerisque mi, nec pretium libero tincidunt at. Aliquam vitae libero massa. Aliquam dignissim
          ultricies pharetra. Quisque rutrum leo ut ex dapibus, et malesuada leo vehicula. ​
        </p>
      </div>
      <div class="col-sm-8">
        <div id="carousel" class="carousel slide" data-ride="carousel">
          <ol class="carousel-indicators">
            <li data-target="#carousel" data-slide-to="0" class="active"></li>
            <li data-target="#carousel" data-slide-to="1"></li>
            <li data-target="#carousel" data-slide-to="2"></li>
          </ol>
          <div class="carousel-inner">
            <div class="carousel-item active">
              <img class="d-block w-100" src="https://picsum.photos/800/600/?45" alt="First Image">
              <div class="carousel-caption d-none d-md-block">
                <h5>First Image</h5>
                <p>Describe First Image</p>
              </div>
            </div>
            <div class="carousel-item">
              <img class="d-block w-100" src="https://picsum.photos/800/600/?32" alt="Second Image">
              <div class="carousel-caption d-none d-md-block">
                <h5>Second Image</h5>
                <p>Describe Second Image</p>
              </div>
            </div>
            <div class="carousel-item">
              <img class="d-block w-100" src="https://picsum.photos/800/600/?76" alt="Third Image">
              <div class="carousel-caption d-none d-md-block">
                <h5>Third Image</h5>
                <p>Describe Third Image</p>
              </div>
            </div>
          </div>
          <a class="carousel-control-prev" href="#carousel" role="button" data-slide="prev">
            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            <span class="sr-only">Previous</span>
          </a>
          <a class="carousel-control-next" href="#carousel" role="button" data-slide="next">
            <span class="carousel-control-next-icon" aria-hidden="true"></span>
            <span class="sr-only">Next</span>
          </a>
        </div>
      </div>
    </div>

  </div>
</div>

<?php include("footer.php"); ?>
