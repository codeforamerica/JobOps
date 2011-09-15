( function( $ ) {
  $.fn.ipValidate = function( options ) {
    var defaults = {
      submitHandler : function() {
        return true;
      },
      classes : {}
    };
    if( options ) {
      for( var eachClass in options ) {
        var classHandler = options[ eachClass ];
        if( classHandler.rule && classHandler.onError && classHandler.onValid ) {
          defaults.classes[ eachClass ] = classHandler;
        } else if( defaults[ eachClass ] ) {
          defaults[ eachClass ] = options[ eachClass ];
        }
      }
    }

    return this.each( function() {
      if( this.nodeName != 'FORM' ) {
        return true;
      }
      var $form = $( this );
      $( this ).bind( 'submit', function( e ) {
        var isValid = true;
        for( var eachClass in defaults.classes ) {
          $( '.' + eachClass, this ).each( function() {
            if( this.hadError ) {
              isValid = false;
              return true;
            }

            this.hadError = false;
            this.validationRule = defaults.classes[ eachClass ].rule;
            this.onErrorDoThis = defaults.classes[ eachClass ].onError;
            this.onValidDoThis = defaults.classes[ eachClass ].onValid

            if( !this.validationRule( this ) ) {
              this.hadError = true;
              isValid = false;
              this.onErrorDoThis( this );
              if( ( this.nodeName == 'INPUT' && ( $( this ).attr( 'type' ) == 'text' || $( this ).attr( 'type' ) == 'password' ) ) || this.nodeName == 'TEXTAREA' ) {
                $( this ).bind( 'keyup', function() {
                  if( !this.hadError ) {
                    return;
                  }
                  if( this.validationRule( this ) ) {
                    this.hadError = false;
                    this.onValidDoThis( this );
                  }
                }).focusout( function() {
                  $( this ).trigger( 'keyup' );
                });
              } else {
                var $textFields = $( 'input[type=text]', this );
                if( $textFields.length > 0 ) {
                  var validationField = this;
                  $textFields.bind( 'keyup', function(){
                    $( validationField ).trigger( 'change' );
                  });
                }
                $( this ).bind( 'change', function() {
                  if( !this.hadError ) {
                    return;
                  }
                  if( this.validationRule( this ) ) {
                    this.hadError = false;
                    this.onValidDoThis( this );
                  }
                });
              }
            }
          });
        }
        if( isValid ) {
          return defaults.submitHandler.call( this, this );
        } else {
          return false;
        }
      });
    });
  }
})( jQuery );