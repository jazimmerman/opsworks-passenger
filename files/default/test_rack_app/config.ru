def taco
  a = []
  100.times do |i|
    a[i] = []
    1000.downto(1) do |j|
      a[i][j] = Math.sqrt(j) * i / 0.2
    end
  end
  a
end

app = proc do |env|
  [200, { "Content-Type" => "text/html" }, [taco]]
end
run app