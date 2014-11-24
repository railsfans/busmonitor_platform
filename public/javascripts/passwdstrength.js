Ext.define('Ext.ux.form.PasswordMeter', {
    extend : 'Ext.form.field.Text',
    alias : 'widget.ux.passwordmeter',
    inputType : 'password',

    reset : function() {
        this.callParent();
        this.updateMeter(this);
    },

    fieldSubTpl : [ 
        '<div><input id="{id}" type="{type}" ', 
        '<tpl if="name">name="{name}" </tpl>', 
        '<tpl if="size">size="{size}" </tpl>',
        '<tpl if="tabIdx">tabIndex="{tabIdx}" </tpl>', 
        'class="{fieldCls} {typeCls}" autocomplete="off" /></div>', 
        '<div class="strengthmeter">',
        '<div class="scorebar">&nbsp;</div>', 
        '</div>', {
            compiled : true,
            disableFormats : true
        } ],

    // private
    onChange : function(newValue, oldValue) {
        this.updateMeter(newValue);
    },
    /**
     * Sets the width of the meter, based on the score
     * 
     * @param {Object}
     *            e Private function
     */
    updateMeter : function(val) {
        var me = this, maxWidth, score, scoreWidth, objMeter = me.el.down('.strengthmeter'), scoreBar = me.el.down('.scorebar');

        maxWidth = objMeter.getWidth();
        score = me.calcStrength(val);
        scoreWidth = maxWidth - (maxWidth / 100) * score;
        scoreBar.setWidth(scoreWidth, true);
    },

    /**
     * Calculates the strength of a password
     * 
     * @param {Object}
     *            p The password that needs to be calculated
     * @return {int} intScore The strength score of the password
     */
    calcStrength : function(p) {
        var intScore = 0;

        // PASSWORD LENGTH
        intScore += p.length;

        if (p.length > 0 && p.length <= 4) { // length 4 or
            // less
            intScore += p.length;
        } else if (p.length >= 5 && p.length <= 7) {
            // length between 5 and 7
            intScore += 6;
        } else if (p.length >= 8 && p.length <= 15) {
            // length between 8 and 15
            intScore += 12;
        } else if (p.length >= 16) { // length 16 or more
            intScore += 18;
        }

        // LETTERS (Not exactly implemented as dictacted above
        // because of my limited understanding of Regex)
        if (p.match(/[a-z]/)) {
            // [verified] at least one lower case letter
            intScore += 1;
        }
        if (p.match(/[A-Z]/)) { // [verified] at least one upper
            // case letter
            intScore += 5;
        }
        // NUMBERS
        if (p.match(/\d/)) { // [verified] at least one
            // number
            intScore += 5;
        }
         if (p.match(/(?:.*?\d){3}/)) {
            // [verified] at least three numbers
            intScore += 5;
        }
 
        // SPECIAL CHAR
        if (p.match(/[\!,@,#,$,%,\^,&,\*,\?,_,~]/)) {
            // [verified] at least one special character
            intScore += 5;
        }
        // [verified] at least two special characters
        if (p.match(/(?:.*?[\!,@,#,$,%,\^,&,\*,\?,_,~]){2}/)) {
            intScore += 5;
        }

        // COMBOS
        if (p.match(/(?=.*[a-z])(?=.*[A-Z])/)) {
            // [verified] both upper and lower case
            intScore += 2;
        }
        if (p.match(/(?=.*\d)(?=.*[a-z])(?=.*[A-Z])/)) {
            // [verified] both letters and numbers
            intScore += 2;
        }
        // [verified] letters, numbers, and special characters
        if (p.match(/(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[\!,@,#,$,%,\^,&,\*,\?,_,~])/)) {
            intScore += 2;
        }

        var nRound = Math.round(intScore * 2);

        if (nRound > 100) {
            nRound = 100;
        }
         return nRound;
    }
});