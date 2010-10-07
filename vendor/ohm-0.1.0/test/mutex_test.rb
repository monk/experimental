# encoding: UTF-8

require File.expand_path("./helper", File.dirname(__FILE__))

class Person < Ohm::Model
  attribute :name
end

setup do
  @p1 = Person.create :name => "Albert"
  @p2 = Person[1]
end

test "prevent other instances of the same object from grabing a locked record" do
  t1 = t2 = nil
  p1 = Thread.new do
    @p1.mutex do
      sleep 0.01
      t1 = Time.now
    end
  end

  p2 = Thread.new do
    sleep 0.01
    @p2.mutex do
      t2 = Time.now
    end
  end

  p1.join
  p2.join
  assert t2 > t1
end

test "allow an instance to lock a record if the previous lock is expired" do
  @p1.send(:lock!)
  @p2.mutex do
    assert true
  end
end

test "work if two clients are fighting for the lock" do
  @p1.send(:lock!)
  @p3 = Person[1]
  @p4 = Person[1]

  p1 = Thread.new { @p1.mutex {} }
  p2 = Thread.new { @p2.mutex {} }
  p3 = Thread.new { @p3.mutex {} }
  p4 = Thread.new { @p4.mutex {} }
  p1.join
  p2.join
  p3.join
  p4.join
end

test "yield the right result after a lock fight" do
  class Candidate < Ohm::Model
    attribute :name
    counter :votes
  end

  @candidate = Candidate.create :name => "Foo"
  @candidate.send(:lock!)

  threads = []

  n = 3
  m = 2

  n.times do
    threads << Thread.new do
      m.times do
        @candidate.mutex do
          sleep 0.01
          @candidate.incr(:votes)
        end
      end
    end
  end

  threads.each { |t| t.join }
  assert n * m == @candidate.votes
end
