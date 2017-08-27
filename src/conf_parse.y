class CFParser
rule

  file    : kv_list opteol

  kv_list : opteol KEY val EOS
              {
                result = [ [ val[1], val[2], nil ] ]
              }
          | opteol KEY val block
              {
                result = [ [ val[1], val[2], val[3] ] ]
              }
          | kv_list opteol KEY val EOS
              {
                val[0].push [val[2], val[3], nil]
              }
          | kv_list opteol KEY val block
              {
                val[0].push [val[2], val[3], val[4]]
              }

  block   : '{' kv_list opteol '}'
              {
                result = val[1]
              }

  val     : 
          | VALUE
          | val eols VALUE
              {
                result = val[0] + "\n" + val[2]
              }

  eols    : EOL
              {
                @lineno += 1
              }
          | eols EOL
              {
                @lineno += 1
              }

  opteol  :
          | eols

end

---- inner
  def parse(f, fname, debug)
    @fname = fname
    
    @q = []
    key_found = nil
    f.each do |line|
      until line.empty? do
        unless key_found
          case line
          when /\A\s+/
            ;
          when /\A#.*/
            ;
          when /\A[^;\s{}]+/
            @q.push [:KEY, $&]
            key_found = 1
          when /\A[{}]/
            @q.push [$&, $&]
          else
            raise RuntimeError, "must not happen"
          end
        else
          case line
          when /\A\s+/
            ;
          when /\A#.*/
            ;
          when /\A[^;\s{}]+[^;{}]*[^;\s{}]/
            @q.push [:VALUE, $&]
          when /\A[^;\s{}]/
            @q.push [:VALUE, $&]
          when /\A;/
            @q.push [:EOS, :EOS]
            key_found = nil
          when /\A{/
            @q.push [$&, $&]
            key_found = nil
          else
            raise RuntimeError, "must not happen"
          end
        end

        line = $'
      end
      @q.push [:EOL, :EOL]
    end
    @q.push [false, '$']

    @lineno = 1
    @yydebug = $DEBUG
    if debug
      p @q
    end
    do_parse
  end

  def next_token
    @q.shift
  end

  def on_error(t, v, _values)
    raise Racc::ParseError,
          "in #{@fname}:#{@lineno}: parse error on #{v.inspect}"
  end
